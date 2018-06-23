package fr.jhandguy.swiftkotlination.navigation

import android.app.Activity
import android.content.Intent
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import javax.inject.Singleton

interface Navigator {
    var activity: Activity
    fun showTopStories()
    fun show(story: Story)
}

@Singleton
class NavigatorImpl: Navigator {
    override lateinit var activity: Activity

    override fun showTopStories() {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity.startActivity(intent)
        activity.finish()
    }

    override fun show(story: Story) {
        val intent = Intent(activity, StoryActivity::class.java)
        intent.putExtra(story.javaClass.simpleName, story)
        activity.startActivity(intent)
    }
}
