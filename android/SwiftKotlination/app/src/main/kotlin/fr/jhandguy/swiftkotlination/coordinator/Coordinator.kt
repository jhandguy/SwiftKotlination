package fr.jhandguy.swiftkotlination.coordinator

import android.app.Activity
import android.content.Intent
import android.net.Uri
import fr.jhandguy.story.coordinator.StoryCoordinatorInterface
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.view.StoryActivity
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface
import fr.jhandguy.topstories.view.TopStoriesActivity
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration.Companion.Stable

interface CoordinatorInterface : TopStoriesCoordinatorInterface, StoryCoordinatorInterface {
    fun start(): Intent
}

class Coordinator(val activity: Activity) : CoordinatorInterface {

    override fun start(): Intent {
        val intent = Intent(activity, TopStoriesActivity::class.java)
        activity.startActivity(intent)
        activity.finish()

        return intent
    }

    override fun open(story: Story): Intent {
        val intent = Intent(activity, StoryActivity::class.java)
        intent.putExtra(story.javaClass.simpleName, Json(Stable).stringify(Story.serializer(), story))
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
