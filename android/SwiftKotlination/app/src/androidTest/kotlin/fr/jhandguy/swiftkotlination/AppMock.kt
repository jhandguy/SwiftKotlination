package fr.jhandguy.swiftkotlination

import fr.jhandguy.swiftkotlination.extensions.absoluteUrl
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.network.NetworkManager
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import java.net.URL
import java.net.URLConnection
import java.net.URLStreamHandler
import java.util.LinkedList
import kotlin.properties.Delegates

typealias Responses = HashMap<Request, LinkedList<Response>>

open class AppMock : App() {

    var responses: Responses by Delegates.observable(HashMap()) { _, _, _ ->
        val responses = responses.map {
            Pair(it.key.absoluteUrl(), it.value)
        }.toMap()

        val handler = object : URLStreamHandler() {
            override fun openConnection(url: URL): URLConnection? {
                return responses[url.toString()]?.let { responses ->
                    if (responses.isEmpty()) {
                        return null
                    }

                    return responses.pop()?.urlConnection
                }
            }
        }

        factory = DependencyManager(NetworkManager(handler))
    }
}