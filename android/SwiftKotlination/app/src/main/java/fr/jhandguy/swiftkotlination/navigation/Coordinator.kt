package fr.jhandguy.swiftkotlination.navigation

import fr.jhandguy.swiftkotlination.features.story.model.Story
import javax.inject.Inject
import javax.inject.Singleton

interface Coordinator {
    fun start()
    fun open(story: Story)
}

@Singleton
class CoordinatorImpl @Inject constructor(private val navigator: Navigator): Coordinator {

    override fun start() {
        navigator.showTopStories()
    }

    override fun open(story: Story) {
        navigator.show(story)
    }

}