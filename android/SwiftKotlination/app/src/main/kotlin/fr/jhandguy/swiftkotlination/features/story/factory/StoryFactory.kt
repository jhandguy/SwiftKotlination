package fr.jhandguy.swiftkotlination.features.story.factory

import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory
import fr.jhandguy.swiftkotlination.factory.ImageFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel

interface StoryFactory: CoordinatorFactory, ImageFactory {
    fun makeStoryManager(story: Story): StoryManagerInterface
    fun makeStoryViewModel(story: Story): StoryViewModel
}