package fr.jhandguy.swiftkotlination.features.topstories.model

import io.reactivex.Observable
import retrofit2.http.GET
import retrofit2.http.Query

interface TopStoriesService {
    @GET("/svc/topstories/v2/home.json")
    fun getObservable(@Query("api-key") apiKey: String = "de87f25eb97b4f038d8360e0de22e1dd"): Observable<TopStories>
}