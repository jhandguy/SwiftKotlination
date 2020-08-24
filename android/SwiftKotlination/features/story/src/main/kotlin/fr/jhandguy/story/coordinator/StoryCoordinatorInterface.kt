package fr.jhandguy.story.coordinator

import android.content.Intent

interface StoryCoordinatorInterface {
    fun open(url: String): Intent
    fun finish()
}
