package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.network.Result
import java.io.IOException

interface TopStoriesRepository {
    suspend fun topStories(observer: (Result<TopStories>) -> (Unit))
}

class TopStoriesRepositoryImpl(private val topStoriesService: TopStoriesService): TopStoriesRepository {
    override suspend fun topStories(observer: (Result<TopStories>) -> (Unit)) {
        try {
            val response = topStoriesService.topStories().await()
            if (response.isSuccessful) {
                response.body()?.let {
                    observer(Result.Success(it))
                }
            }

            observer(Result.Failure(IOException("Error fetching top stories: ${response.code()} - ${response.message()}")))

        } catch (e: Exception) {
            observer(Result.Failure(IOException("Error fetching top stories", e)))
        }
    }
}