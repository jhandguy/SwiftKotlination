package fr.jhandguy.topstories.factory

import android.app.Activity
import fr.jhandguy.image.factory.ImageFactory
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface
import fr.jhandguy.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel

interface TopStoriesFactory : ImageFactory {
    fun makeTopStoriesManager(): TopStoriesManagerInterface
    fun makeTopStoriesViewModel(): TopStoriesViewModel
    fun makeTopStoriesCoordinator(activity: Activity): TopStoriesCoordinatorInterface
}
