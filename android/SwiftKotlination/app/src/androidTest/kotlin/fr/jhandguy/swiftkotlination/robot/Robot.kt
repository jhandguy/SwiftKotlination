package fr.jhandguy.swiftkotlination.robot

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.widget.AppCompatTextView
import androidx.test.core.app.ApplicationProvider.getApplicationContext
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.Espresso.pressBack
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.RootMatchers.isDialog
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.Responses
import org.hamcrest.CoreMatchers.instanceOf
import org.junit.ClassRule
import tools.fastlane.screengrab.Screengrab.screenshot
import tools.fastlane.screengrab.Screengrab.setDefaultScreenshotStrategy
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy
import tools.fastlane.screengrab.locale.LocaleTestRule

open class Robot<T : Activity>(val activityRule: ActivityTestRule<T>) {

    companion object {
        @get:ClassRule
        val localeTestRule = LocaleTestRule()
    }

    init {
        setDefaultScreenshotStrategy(UiAutomatorScreenshotStrategy())
    }
}

fun <T : Activity, R : Robot<T>> R.takeScreenshot(name: String): R {
    try {
        screenshot(name)
    } catch (exception: Exception) {
        println(exception.message)
    }

    return this
}

fun <T : Activity, R : Robot<T>> R.checkTitle(title: String): R {
    onView(instanceOf(AppCompatTextView::class.java))
            .check(matches(withText(title)))

    return this
}

fun <T : Activity, R : Robot<T>> R.start(responses: Responses, extras: Bundle = Bundle()): R {
    val application = getApplicationContext<AppMock>()
    application.responses = responses

    val intent = Intent()
    intent.putExtras(extras)

    activityRule.launchActivity(intent)

    return this
}

fun <T : Activity, R : Robot<T>> R.back(): R {
    pressBack()

    return this
}

fun <T : Activity, R : Robot<T>> R.checkAlert(error: Error): R {
    onView(withText(error.message))
            .inRoot(isDialog())
            .check(matches(isDisplayed()))

    return this
}

fun <T : Activity, R : Robot<T>> R.closeAlert(): R {
    onView(withText(android.R.string.ok))
            .inRoot(isDialog())
            .perform(click())

    return this
}