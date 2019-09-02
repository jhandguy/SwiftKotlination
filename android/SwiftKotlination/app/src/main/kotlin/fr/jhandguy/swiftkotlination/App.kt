package fr.jhandguy.swiftkotlination

import android.app.Application
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.network.NetworkManager

open class App : Application() {
    lateinit var factory: DependencyManager

    override fun onCreate() {
        super.onCreate()
        factory = DependencyManager(NetworkManager())
    }
}
