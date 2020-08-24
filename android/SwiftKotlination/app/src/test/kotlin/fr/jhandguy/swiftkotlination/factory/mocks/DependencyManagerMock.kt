package fr.jhandguy.swiftkotlination.factory.mocks

import android.app.Activity
import fr.jhandguy.image.model.ImageManagerInterface
import fr.jhandguy.network.model.network.NetworkManager
import fr.jhandguy.network.model.network.NetworkManagerInterface
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManagerInterface
import fr.jhandguy.story.viewmodel.StoryViewModel
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel

class DependencyManagerMock(
    networkManager: NetworkManagerInterface = NetworkManager(),
    val coordinator: CoordinatorInterface? = null,
    val topStoriesManager: TopStoriesManagerInterface? = null,
    val imageManager: ImageManagerInterface? = null,
    val storyManager: StoryManagerInterface? = null
) : DependencyManager(networkManager) {

    override fun makeCoordinator(activity: Activity): CoordinatorInterface = coordinator ?: super.makeCoordinator(activity)
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = topStoriesManager ?: super.makeTopStoriesManager()
    override fun makeImageManager(): ImageManagerInterface = imageManager ?: super.makeImageManager()
    override fun makeStoryManager(story: Story): StoryManagerInterface = storyManager ?: super.makeStoryManager(story)
}
