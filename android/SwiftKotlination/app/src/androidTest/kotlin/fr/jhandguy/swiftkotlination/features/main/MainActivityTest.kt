package fr.jhandguy.swiftkotlination.features.main

import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.swiftkotlination.AppMock
import org.junit.Test

class MainActivityTest {
    @Test
    fun `test`() {
        val application = ApplicationProvider.getApplicationContext<AppMock>()
        println(application)
    }
}