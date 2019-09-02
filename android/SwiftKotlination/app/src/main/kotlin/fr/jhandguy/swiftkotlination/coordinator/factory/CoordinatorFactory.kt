package fr.jhandguy.swiftkotlination.coordinator.factory

import android.app.Activity
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface

interface CoordinatorFactory {
    fun makeCoordinator(activity: Activity): CoordinatorInterface
}
