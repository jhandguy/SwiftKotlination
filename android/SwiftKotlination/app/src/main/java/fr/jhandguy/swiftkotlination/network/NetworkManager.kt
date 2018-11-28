package fr.jhandguy.swiftkotlination.network

import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLStreamHandler
import java.util.*
import kotlin.collections.HashMap
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

interface NetworkManagerInterface {
    suspend fun observe(request: Request, observer: Observer<ByteArray>): Disposable
    suspend fun execute(request: Request)
}

class NetworkManager(val handler: URLStreamHandler? = null, var observables: MutableMap<Request, MutableMap<UUID, Observer<ByteArray>>> = HashMap()): NetworkManagerInterface {

    private suspend fun execute(request: Request, observers: List<Observer<ByteArray>>) {
        if (observers.isEmpty()) { return }

        build(request)?.let { connection ->
            connection.inputStream?.let { data ->
                val bytes = data.readBytes()
                observers.forEach { it(Result.Success(bytes)) }
            } ?: connection.errorStream?.let { error ->
                val bytes = error.readBytes()
                observers.forEach { it(Result.Failure(Error(String(bytes)))) }
            }
            connection.disconnect()
        } ?: observers.forEach { it(Result.Failure(NetworkError.InvalidRequest())) }
    }

    private suspend fun build(request: Request): HttpURLConnection? = suspendCoroutine { continuation ->
        try {
            val urlWithParameters = request.url + when(request.parameters) {
                is Parameters.Url -> "?${(request.parameters as Parameters.Url).url.joinToString("&") { (key, value) -> "$key=$value" }}"
                else -> ""
            }
            val url = URL(null, urlWithParameters, handler)
            val connection = url.openConnection() as HttpURLConnection
            connection.apply {
                requestMethod = request.method.name
                when(request.parameters) {
                    is Parameters.Body -> outputStream.write((request.parameters as Parameters.Body).body.toString().toByteArray())
                    else -> {}
                }
            }
            continuation.resume(connection)

        } catch(e: Exception) {
            continuation.resume(null)
        }
    }

    override suspend fun observe(request: Request, observer: Observer<ByteArray>): Disposable {
        val uuid = UUID.randomUUID()
        val observers = observables[request] ?: HashMap()
        observers[uuid] = observer
        observables[request] = observers

        execute(request, listOf(observer))

        return Disposable {
            observables[request]?.remove(uuid)
        }
    }

    override suspend fun execute(request: Request) {
        observables[request]?.let { observers ->
            execute(request, observers.map { it.value })
        }
    }
}