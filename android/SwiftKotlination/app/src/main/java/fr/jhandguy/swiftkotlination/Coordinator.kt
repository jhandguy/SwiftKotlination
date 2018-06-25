package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.content.Intent
import android.net.Uri
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import javax.inject.Inject

interface Coordinator {
    fun start()
    fun open(story: Story)
    fun open(url: String)
    fun finish()
}

class CoordinatorImpl @Inject constructor(val activity: Activity): Coordinator {

    override fun start() {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity.startActivity(intent)
        activity.finish()
    }

    override fun open(story: Story) {
        val intent = Intent(activity, StoryActivity::class.java)
        intent.putExtra(story.javaClass.simpleName, story)
        activity.startActivity(intent)
    }

    override fun open(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        activity.startActivity(intent)
    }

    override fun finish() {
        activity.finish()
    }
}