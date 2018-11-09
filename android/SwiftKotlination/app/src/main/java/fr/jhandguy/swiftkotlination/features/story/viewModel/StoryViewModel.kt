package fr.jhandguy.swiftkotlination.features.story.viewModel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.observer.Observer

class StoryViewModel(private val manager: StoryManagerInterface) {
    suspend fun story(observer: Observer<Story>) = manager.story(observer)
}