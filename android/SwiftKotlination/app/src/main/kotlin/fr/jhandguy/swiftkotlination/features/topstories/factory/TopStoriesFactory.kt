package fr.jhandguy.swiftkotlination.features.topstories.factory

import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory
import fr.jhandguy.swiftkotlination.factory.ImageFactory
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel

interface TopStoriesFactory : CoordinatorFactory, ImageFactory {
    fun makeTopStoriesManager(): TopStoriesManagerInterface
    fun makeTopStoriesViewModel(): TopStoriesViewModel
}
