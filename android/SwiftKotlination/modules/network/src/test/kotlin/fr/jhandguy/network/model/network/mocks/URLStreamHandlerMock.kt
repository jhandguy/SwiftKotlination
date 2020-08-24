package fr.jhandguy.network.model.network.mocks

import fr.jhandguy.test.network.Response
import java.net.URL
import java.net.URLConnection
import java.net.URLStreamHandler
import java.util.Stack

class URLStreamHandlerMock(val responses: Stack<Response>) : URLStreamHandler() {
    init {
        responses.reverse()
    }

    override fun openConnection(url: URL?): URLConnection = responses.pop().urlConnection
}
