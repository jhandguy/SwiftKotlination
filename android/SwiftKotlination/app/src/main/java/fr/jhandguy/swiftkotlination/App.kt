package fr.jhandguy.swiftkotlination

import android.app.Application
import android.content.Intent
import fr.jhandguy.swiftkotlination.features.topstories.activities.TopStoriesActivity

class App: Application() {
    override fun onCreate() {
        super.onCreate()
        val intent = Intent(this, TopStoriesActivity::class.java)
        startActivity(intent)
    }
}