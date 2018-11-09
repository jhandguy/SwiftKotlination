package fr.jhandguy.swiftkotlination.features.main.view

import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.navigation.CoordinatorInterface
import org.koin.android.ext.android.inject
import org.koin.core.parameter.parametersOf

class MainActivity: AppCompatActivity() {

    val coordinator: CoordinatorInterface by inject { parametersOf(this) }

    override fun onStart() {
        super.onStart()
        coordinator.start()
    }
}