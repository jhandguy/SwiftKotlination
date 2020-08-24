package fr.jhandguy.swiftkotlination.application

import android.app.Application
import fr.jhandguy.network.model.network.NetworkManager
import fr.jhandguy.story.factory.StoryFactory
import fr.jhandguy.story.feature.StoryFeature
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.factory.Factory
import fr.jhandguy.topstories.factory.TopStoriesFactory
import fr.jhandguy.topstories.feature.TopStoriesFeature

interface AppInterface : TopStoriesFeature, StoryFeature {
    val factory: Factory
}

open class App : Application(), AppInterface {
    override lateinit var factory: Factory

    override val storyFactory: StoryFactory
        get() = factory

    override val topStoriesFactory: TopStoriesFactory
        get() = factory

    override fun onCreate() {
        super.onCreate()
        factory = DependencyManager(NetworkManager())
    }
}
