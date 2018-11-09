package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.serialization.json.JSON

interface TopStoriesManagerInterface {
    suspend fun topStories(observer: Observer<TopStories>): Disposable
    suspend fun fetchStories()
}

class TopStoriesManager(private val networkManager: NetworkManagerInterface): TopStoriesManagerInterface {
    override suspend fun topStories(observer: Observer<TopStories>) =
            networkManager.observe(Request.FetchTopStories) { result ->
                when(result) {
                    is Result.Success -> observer(Result.Success(JSON(strictMode = false).parse(TopStories.serializer(), result.data)))
                    is Result.Failure -> observer(result)
                }
            }

    override suspend fun fetchStories() = networkManager.execute(Request.FetchTopStories)
}