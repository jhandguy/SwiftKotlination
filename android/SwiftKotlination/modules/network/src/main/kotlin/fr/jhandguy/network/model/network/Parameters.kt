package fr.jhandguy.network.model.network

sealed class Parameters {
    data class Body(val body: Any) : Parameters()
    data class Url(val url: List<Pair<String, String?>>) : Parameters()
    object None : Parameters()
}
