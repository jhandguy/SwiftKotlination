package fr.jhandguy.swiftkotlination.view

import android.app.Activity
import fr.jhandguy.swiftkotlination.application.AppInterface

class MainActivity : Activity() {

    private val factory by lazy { (application as AppInterface).factory }
    private val coordinator by lazy { factory.makeCoordinator(this) }

    override fun onStart() {
        super.onStart()
        coordinator.start()
    }
}
