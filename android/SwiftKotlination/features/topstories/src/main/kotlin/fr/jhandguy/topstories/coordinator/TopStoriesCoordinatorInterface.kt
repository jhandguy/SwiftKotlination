package fr.jhandguy.topstories.coordinator

import android.content.Intent
import fr.jhandguy.story.model.Story

interface TopStoriesCoordinatorInterface {
    fun open(story: Story): Intent
}
