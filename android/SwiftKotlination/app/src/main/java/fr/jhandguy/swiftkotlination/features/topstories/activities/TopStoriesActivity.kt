package fr.jhandguy.swiftkotlination.features.topstories.activities

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import org.jetbrains.anko.textView
import org.jetbrains.anko.verticalLayout

class TopStoriesActivity: AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        verticalLayout {
            textView("Title")
            textView("Description")
        }
    }
}