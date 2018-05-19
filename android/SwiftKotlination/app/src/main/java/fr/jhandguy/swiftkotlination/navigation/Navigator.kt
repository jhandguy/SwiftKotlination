package fr.jhandguy.swiftkotlination.navigation

import android.app.Activity
import android.content.Intent
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import javax.inject.Singleton

interface Navigator {
    var activity: Activity?
    fun showTopStories()
}

@Singleton
class NavigatorImpl: Navigator {
    override var activity: Activity? = null

    override fun showTopStories() {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity?.startActivity(intent)
        activity?.finish()
    }

}
