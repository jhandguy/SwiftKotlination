package fr.jhandguy.swiftkotlination.features.story.factory.mocks

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel

class StoryFactoryMock(val manager: StoryManagerInterface): StoryFactory {
    override fun makeStoryManager(story: Story): StoryManagerInterface = manager
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
}