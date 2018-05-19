package fr.jhandguy.swiftkotlination.navigation

import javax.inject.Inject
import javax.inject.Singleton

interface Coordinator {
    fun start()
}

@Singleton
class CoordinatorImpl @Inject constructor(private val navigator: Navigator): Coordinator {

    override fun start() {
        navigator.showTopStories()
    }

}