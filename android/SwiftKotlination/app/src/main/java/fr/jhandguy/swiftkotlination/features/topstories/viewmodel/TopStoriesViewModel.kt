package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class TopStoriesViewModel(factory: TopStoriesFactory) {
    private val manager = factory.makeTopStoriesManager()

    suspend fun topStories(observer: Observer<List<Story>>) = manager.topStories { result ->
        when (result) {
            is Result.Success -> observer(Result.Success(result.data.results))
            is Result.Failure -> observer(result)
        }
    }

    suspend fun refresh() = manager.fetchStories()
}