package fr.jhandguy.swiftkotlination.features.main

import androidx.test.core.app.ApplicationProvider
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import org.junit.Rule
import org.junit.Test

class MainActivityTest {
    @get:Rule
    val activityRule = ActivityTestRule(MainActivity::class.java)

    @Test
    fun `test`() {
        val application = ApplicationProvider.getApplicationContext<AppMock>()
        println(application)
    }
}