package fr.jhandguy.network.model.network

sealed class NetworkError : Error() {
    class InvalidRequest : NetworkError()
    class InvalidResponse : NetworkError()

    override val message: String
        get() = when (this) {
            is InvalidRequest -> "Invalid request, please try again later."
            is InvalidResponse -> "Invalid response, please try again later."
        }
}
