package fr.jhandguy.swiftkotlination.features.story.viewModel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.Result

class StoryViewModel(private val repository: StoryRepository) {
    suspend fun story(observer: (Result<Story>) -> Unit) = repository.story(observer)
}