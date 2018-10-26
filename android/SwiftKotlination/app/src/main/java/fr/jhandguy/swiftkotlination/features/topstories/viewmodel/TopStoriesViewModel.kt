package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import fr.jhandguy.swiftkotlination.network.Result

class TopStoriesViewModel(private val repository: TopStoriesRepository) {
    suspend fun topStories(observer: (Result<List<Story>>) -> Unit) = repository.topStories { result ->
        when (result) {
            is Result.Success -> observer(Result.Success(result.data.results))
            is Result.Failure -> observer(result)
        }
    }
}