package fr.jhandguy.swiftkotlination.global

import android.os.Build
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

fun launch(block: suspend CoroutineScope.() -> Unit) {
    val dispatcher: CoroutineDispatcher = if (Build.FINGERPRINT == "robolectric") Dispatchers.Unconfined else Dispatchers.Default
    CoroutineScope(dispatcher).launch(block = block)
}