package fr.jhandguy.topstories.application

import android.app.Application
import fr.jhandguy.topstories.factory.TopStoriesFactory
import fr.jhandguy.topstories.feature.TopStoriesFeature

internal open class TopStoriesApp : Application(), TopStoriesFeature {
    lateinit var factory: TopStoriesFactory

    override val topStoriesFactory: TopStoriesFactory
        get() = factory
}
