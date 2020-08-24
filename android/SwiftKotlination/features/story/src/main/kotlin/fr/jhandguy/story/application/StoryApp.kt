package fr.jhandguy.story.application

import android.app.Application
import fr.jhandguy.story.factory.StoryFactory
import fr.jhandguy.story.feature.StoryFeature

internal open class StoryApp : Application(), StoryFeature {
    lateinit var factory: StoryFactory

    override val storyFactory: StoryFactory
        get() = factory
}
