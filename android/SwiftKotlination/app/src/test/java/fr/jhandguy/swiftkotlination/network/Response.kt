package fr.jhandguy.swiftkotlination.network

import fr.jhandguy.swiftkotlination.network.mocks.HttpURLConnectionMock

class Response(file: File? = null, error: NetworkError? = null) {
    val urlConnection: HttpURLConnectionMock = HttpURLConnectionMock(file, error)
}