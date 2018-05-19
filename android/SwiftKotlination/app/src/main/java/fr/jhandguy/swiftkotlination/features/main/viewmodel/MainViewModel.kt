package fr.jhandguy.swiftkotlination.features.main.viewmodel

import fr.jhandguy.swiftkotlination.navigation.Coordinator
import javax.inject.Inject

class MainViewModel @Inject constructor(val coordinator: Coordinator) {
    fun start() {
        coordinator.start()
    }
}