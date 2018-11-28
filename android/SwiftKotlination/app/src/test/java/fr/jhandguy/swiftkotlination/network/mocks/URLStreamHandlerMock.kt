package fr.jhandguy.swiftkotlination.network.mocks

import fr.jhandguy.swiftkotlination.network.Response
import java.net.URL
import java.net.URLConnection
import java.net.URLStreamHandler
import java.util.*

class URLStreamHandlerMock(val responses: Stack<Response>) : URLStreamHandler() {
    init {
        responses.reverse()
    }

    override fun openConnection(url: URL?): URLConnection = responses.pop().urlConnection
}