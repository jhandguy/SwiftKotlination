package fr.jhandguy.swiftkotlination.network

import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.suspendCancellableCoroutine
import java.net.HttpURLConnection
import java.net.URL
import java.util.*
import kotlin.collections.HashMap
import kotlin.coroutines.resume

interface NetworkManagerInterface {
    suspend fun observe(request: Request, observer: Observer<String>): Disposable
    suspend fun execute(request: Request)
}

class NetworkManager(var observables: MutableMap<Request, MutableMap<UUID, Observer<String>>> = HashMap()): NetworkManagerInterface {

    private suspend fun execute(request: Request, observers: List<Observer<String>>) {
        if (observers.isEmpty()) { return }

        build(request)?.let { response ->
            if (response.second / 100 == 2) {
                observers.forEach { it(Result.Success(response.first)) }
            } else {
                observers.forEach { it(Result.Failure(NetworkError.InvalidResponse())) }
            }
        } ?: observers.forEach { it(Result.Failure(NetworkError.InvalidRequest())) }
    }

    private suspend fun build(request: Request): Pair<String, Int>? = suspendCancellableCoroutine { continuation ->
        try {
            val urlWithParameters = request.url + when(request.parameters) {
                is Parameters.Url -> "?${(request.parameters as Parameters.Url).url.joinToString("&") { (key, value) -> "$key=$value" }}"
                else -> ""
            }
            val url = URL(urlWithParameters)
            val connection = url.openConnection() as HttpURLConnection
            connection.apply {
                requestMethod = request.method.name
                when(request.parameters) {
                    is Parameters.Body -> outputStream.write((request.parameters as Parameters.Body).body.toString().toByteArray())
                    else -> {}
                }
            }
            val data = connection.inputStream.bufferedReader().readText()
            continuation.resume(Pair(data, connection.responseCode))

        } catch(e: Exception) {
            continuation.resume(null)
        }
    }

    override suspend fun observe(request: Request, observer: Observer<String>): Disposable {
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