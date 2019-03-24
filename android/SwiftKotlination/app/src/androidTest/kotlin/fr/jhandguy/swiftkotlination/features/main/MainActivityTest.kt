package fr.jhandguy.swiftkotlination.features.main

import android.content.Intent
import androidx.test.core.app.ApplicationProvider
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.Response
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import java.util.Stack

class MainActivityTest {
    @get:Rule
    val activityRule = ActivityTestRule(MainActivity::class.java, false, false)

    @Before
    fun setup() {
        val application = ApplicationProvider.getApplicationContext<AppMock>()
        val responses = Stack<Response>()
        responses.push(Response(File("top_stories", File.Extension.JSON)))
        application.responses = responses
    }

    @Test
    fun `test`() {
        activityRule.launchActivity(Intent())
        onView(withId(R.id.top_stories_list))
                .check(matches(isDisplayed()))
    }
}