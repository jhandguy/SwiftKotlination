package fr.jhandguy.swiftkotlination.factory

import android.app.Activity
import fr.jhandguy.image.model.ImageManager
import fr.jhandguy.image.model.ImageManagerInterface
import fr.jhandguy.network.model.network.NetworkManagerInterface
import fr.jhandguy.story.coordinator.StoryCoordinatorInterface
import fr.jhandguy.story.factory.StoryFactory
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManager
import fr.jhandguy.story.model.StoryManagerInterface
import fr.jhandguy.story.viewmodel.StoryViewModel
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface
import fr.jhandguy.topstories.factory.TopStoriesFactory
import fr.jhandguy.topstories.model.TopStoriesManager
import fr.jhandguy.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel

interface Factory : TopStoriesFactory, StoryFactory {
    fun makeCoordinator(activity: Activity): CoordinatorInterface
}

open class DependencyManager(val networkManager: NetworkManagerInterface) : Factory {
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
    override fun makeTopStoriesCoordinator(activity: Activity): TopStoriesCoordinatorInterface = makeCoordinator(activity)
    override fun makeStoryCoordinator(activity: Activity): StoryCoordinatorInterface = makeCoordinator(activity)
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = TopStoriesManager(networkManager)
    override fun makeImageManager(): ImageManagerInterface = ImageManager(networkManager)
    override fun makeStoryManager(story: Story): StoryManagerInterface = StoryManager(story)
}
