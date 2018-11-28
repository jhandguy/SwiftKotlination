package fr.jhandguy.swiftkotlination.features.topstories.factory

import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory

interface TopStoriesFactory: CoordinatorFactory {
    fun makeTopStoriesManager(): TopStoriesManagerInterface
    fun makeTopStoriesViewModel(): TopStoriesViewModel
}