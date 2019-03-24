package fr.jhandguy.swiftkotlination

import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.network.NetworkManager
import fr.jhandguy.swiftkotlination.network.Response
import java.net.URL
import java.net.URLConnection
import java.net.URLStreamHandler
import java.util.Stack
import kotlin.properties.Delegates

open class AppMock : App() {
    var responses: Stack<Response> by Delegates.observable(Stack()) { _, _, _ ->
        val handler = object : URLStreamHandler() {
            override fun openConnection(url: URL): URLConnection? {
                if (responses.isEmpty()) {
                    return null
                }

                return responses.pop().urlConnection
            }
        }

        factory = DependencyManager(NetworkManager(handler))
    }
}