package fr.jhandguy.swiftkotlination.network

sealed class Parameters {
    data class Body(val body: Any): Parameters()
    data class Url(val url: List<Pair<String, String>>): Parameters()
    object None: Parameters()
}