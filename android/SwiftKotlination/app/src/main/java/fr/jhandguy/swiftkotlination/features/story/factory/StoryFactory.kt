package fr.jhandguy.swiftkotlination.features.story.factory

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory

interface StoryFactory: CoordinatorFactory {
    fun makeStoryManager(story: Story): StoryManagerInterface
    fun makeStoryViewModel(story: Story): StoryViewModel
}