package fr.jhandguy.swiftkotlination.features.main.view

import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.Coordinator
import org.koin.android.ext.android.inject

class MainActivity: AppCompatActivity() {

    val coordinator: Coordinator by inject { mapOf("activity" to this)}

    override fun onStart() {
        super.onStart()
        coordinator.start()
    }
}