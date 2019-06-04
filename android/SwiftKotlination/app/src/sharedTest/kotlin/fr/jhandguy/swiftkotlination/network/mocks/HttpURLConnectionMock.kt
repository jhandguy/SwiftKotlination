package fr.jhandguy.swiftkotlination.network.mocks

import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import java.io.InputStream
import java.net.HttpURLConnection

class HttpURLConnectionMock(val file: File?, val error: NetworkError?) : HttpURLConnection(null) {
    var isConnected: Boolean = false

    override fun usingProxy(): Boolean = false

    override fun connect() {
        isConnected = true
    }

    override fun disconnect() {
        isConnected = false
    }

    override fun getInputStream(): InputStream? = file?.data

    override fun getResponseCode(): Int = -1

    override fun getErrorStream(): InputStream? = error?.message?.byteInputStream()
}