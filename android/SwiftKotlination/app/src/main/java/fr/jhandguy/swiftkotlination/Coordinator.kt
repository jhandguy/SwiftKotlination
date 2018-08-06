package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.content.Intent
import android.net.Uri
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity

interface Coordinator {
    fun start(): Intent
    fun open(story: Story): Intent
    fun open(url: String): Intent
    fun finish()
}

class CoordinatorImpl(val activity: Activity): Coordinator {

    override fun start(): Intent {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity.startActivity(intent)
        activity.finish()

        return intent
    }

    override fun open(story: Story): Intent {
        val intent = Intent(activity, StoryActivity::class.java)
        intent.putExtra(story.javaClass.simpleName, story)
        activity.startActivity(intent)

        return intent
    }

    override fun open(url: String): Intent {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        activity.startActivity(intent)

        return intent
    }

    override fun finish() {
        activity.finish()
    }
}