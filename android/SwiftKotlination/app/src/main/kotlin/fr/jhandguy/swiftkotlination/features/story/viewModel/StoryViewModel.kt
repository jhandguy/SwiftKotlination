package fr.jhandguy.swiftkotlination.features.story.viewModel

import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.observer.Observer

class StoryViewModel(factory: StoryFactory, story: Story = Story()) {
    private val manager = factory.makeStoryManager(story)

    suspend fun story(observer: Observer<Story>) = manager.story(observer)
}