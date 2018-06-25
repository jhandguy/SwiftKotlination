package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.features.story.model.Story

class StoryActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val story = intent.extras.getSerializable(Story::class.java.simpleName) as Story

        title = arrayOf(story.section, story.subsection)
                .filter { it.isNotEmpty() }
                .joinToString(separator = " - ")

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }

    override fun onSupportNavigateUp(): Boolean {
        onBackPressed()
        return true
    }
}