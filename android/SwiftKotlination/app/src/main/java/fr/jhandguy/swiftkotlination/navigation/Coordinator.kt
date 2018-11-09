package fr.jhandguy.swiftkotlination.navigation

import android.app.Activity
import android.content.Intent
import android.net.Uri
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import kotlinx.serialization.json.JSON

interface CoordinatorInterface {
    fun start(): Intent
    fun open(story: Story): Intent
    fun open(url: String): Intent
    fun finish()
}

class Coordinator(val activity: Activity): CoordinatorInterface {

    override fun start(): Intent {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity.startActivity(intent)
        activity.finish()

        return intent
    }

    override fun open(story: Story): Intent {
        val intent = Intent(activity, StoryActivity::class.java)
        intent.putExtra(story.javaClass.simpleName, JSON.stringify(Story.serializer(), story))
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