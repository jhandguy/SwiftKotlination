package fr.jhandguy.swiftkotlination.factory.mocks

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.model.ImageManagerInterface
import fr.jhandguy.swiftkotlination.network.NetworkManager
import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface

class DependencyManagerMock(
    networkManager: NetworkManagerInterface = NetworkManager(),
    val coordinator: CoordinatorInterface? = null,
    val topStoriesManager: TopStoriesManagerInterface? = null,
    val imageManager: ImageManagerInterface? = null,
    val storyManager: StoryManagerInterface? = null): DependencyManager(networkManager) {

    override fun makeCoordinator(activity: Activity): CoordinatorInterface  = coordinator ?: super.makeCoordinator(activity)
    override fun makeTopStoriesViewModel(): TopStoriesViewModel             = TopStoriesViewModel(this)
    override fun makeStoryViewModel(story: Story): StoryViewModel           = StoryViewModel(this, story)
    override fun makeTopStoriesManager(): TopStoriesManagerInterface        = topStoriesManager ?: super.makeTopStoriesManager()
    override fun makeImageManager(): ImageManagerInterface                  = imageManager ?: super.makeImageManager()
    override fun makeStoryManager(story: Story): StoryManagerInterface      = storyManager ?: super.makeStoryManager(story)
}