package fr.jhandguy.swiftkotlination.features.topstories.factory.mocks

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.model.ImageManagerInterface

class TopStoriesFactoryMock(val topStoriesManager: TopStoriesManagerInterface, val imageManager: ImageManagerInterface): TopStoriesFactory {
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = topStoriesManager
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
    override fun makeImageManager(): ImageManagerInterface = imageManager
}