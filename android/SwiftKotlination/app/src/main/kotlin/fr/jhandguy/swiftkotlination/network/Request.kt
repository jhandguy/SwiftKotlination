package fr.jhandguy.swiftkotlination.network

sealed class Request {
    object FetchTopStories: Request()
    data class FetchImage(val imageUrl: String): Request()

    val url: String
        get() = when(this) {
            is FetchTopStories  -> "https://api.nytimes.com/svc/topstories/v2/home.json"
            is FetchImage       -> imageUrl
        }

    val method: HTTPMethod
        get() = when(this) {
            is FetchTopStories  -> HTTPMethod.GET
            is FetchImage       -> HTTPMethod.GET
        }

    val parameters: Parameters
        get() = when(this) {
            is FetchTopStories  -> Parameters.Url(listOf(Pair("api-key", "de87f25eb97b4f038d8360e0de22e1dd")))
            is FetchImage       -> Parameters.None
        }
}