package fr.jhandguy.swiftkotlination

import android.app.Application
import android.os.Build
import fr.jhandguy.swiftkotlination.factory.DependencyManager
import fr.jhandguy.swiftkotlination.network.NetworkManager
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

open class App : Application() {
    lateinit var factory: DependencyManager

    override fun onCreate() {
        super.onCreate()
        factory = DependencyManager(NetworkManager())
    }
}

fun launch(block: suspend CoroutineScope.() -> Unit) {
    val dispatcher: CoroutineDispatcher = if (Build.FINGERPRINT == "robolectric") Dispatchers.Unconfined else Dispatchers.Default
    CoroutineScope(dispatcher).launch(block = block)
}