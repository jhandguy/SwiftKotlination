package fr.jhandguy.topstories.factory.mocks

import android.app.Activity
import fr.jhandguy.image.model.ImageManagerInterface
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface
import fr.jhandguy.topstories.factory.TopStoriesFactory
import fr.jhandguy.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel

class TopStoriesFactoryMock(
    val topStoriesManager: TopStoriesManagerInterface,
    val imageManager: ImageManagerInterface,
    val topStoriesCoordinator: TopStoriesCoordinatorInterface
) : TopStoriesFactory {
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = topStoriesManager
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeTopStoriesCoordinator(activity: Activity): TopStoriesCoordinatorInterface = topStoriesCoordinator
    override fun makeImageManager(): ImageManagerInterface = imageManager
}
