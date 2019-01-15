package fr.jhandguy.swiftkotlination.features.story.factory.mocks

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.model.ImageManagerInterface

class StoryFactoryMock(val storyManager: StoryManagerInterface, val imageManager: ImageManagerInterface) : StoryFactory {
    override fun makeStoryManager(story: Story): StoryManagerInterface = storyManager
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
    override fun makeImageManager(): ImageManagerInterface = imageManager
}