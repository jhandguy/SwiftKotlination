package fr.jhandguy.topstories.model

import fr.jhandguy.network.model.network.NetworkManagerInterface
import fr.jhandguy.network.model.network.Request
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import kotlinx.serialization.json.Json

interface TopStoriesManagerInterface {
    suspend fun topStories(observer: Observer<TopStories>): Disposable
    suspend fun fetchStories()
}

class TopStoriesManager(private val networkManager: NetworkManagerInterface) : TopStoriesManagerInterface {
    override suspend fun topStories(observer: Observer<TopStories>) =
        networkManager.observe(Request.FetchTopStories) { result ->
            when (result) {
                is Result.Success -> observer(Result.Success(Json { ignoreUnknownKeys = true }.decodeFromString(TopStories.serializer(), String(result.data))))
                is Result.Failure -> observer(result)
            }
        }

    override suspend fun fetchStories() = networkManager.execute(Request.FetchTopStories)
}
