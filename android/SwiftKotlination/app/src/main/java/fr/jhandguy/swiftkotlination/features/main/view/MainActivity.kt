package fr.jhandguy.swiftkotlination.features.main.view

import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.coordinator.factory.CoordinatorFactory
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface

class MainActivity: AppCompatActivity() {

    val coordinatorFactory: CoordinatorFactory      by lazy { (application as App).factory }

    private val coordinator: CoordinatorInterface   by lazy { coordinatorFactory.makeCoordinator(this) }

    override fun onStart() {
        super.onStart()
        coordinator.start()
    }
}