package fr.jhandguy.swiftkotlination.features.topstories.factory.mocks

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel

class TopStoriesFactoryMock(val manager: TopStoriesManagerInterface): TopStoriesFactory {
    override fun makeTopStoriesManager(): TopStoriesManagerInterface = manager
    override fun makeTopStoriesViewModel(): TopStoriesViewModel = TopStoriesViewModel(this)
    override fun makeCoordinator(activity: Activity): CoordinatorInterface = Coordinator(activity)
}