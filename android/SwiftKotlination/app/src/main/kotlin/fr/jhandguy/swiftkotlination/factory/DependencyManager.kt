package fr.jhandguy.swiftkotlination.factory

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManager
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManager
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.model.ImageManager
import fr.jhandguy.swiftkotlination.model.ImageManagerInterface
import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface

data class DependencyManager(val networkManager: NetworkManagerInterface) : CoordinatorFactory, TopStoriesFactory, StoryFactory {
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = TopStoriesManager(networkManager)
    override fun makeImageManager(): ImageManagerInterface = ImageManager(networkManager)
    override fun makeStoryManager(story: Story): StoryManagerInterface = StoryManager(story)
}