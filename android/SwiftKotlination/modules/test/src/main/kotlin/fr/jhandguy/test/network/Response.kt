package fr.jhandguy.test.network

import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.test.network.mocks.HttpURLConnectionMock

class Response(file: File? = null, error: NetworkError? = null) {
    val urlConnection: HttpURLConnectionMock = HttpURLConnectionMock(file, error)
}
