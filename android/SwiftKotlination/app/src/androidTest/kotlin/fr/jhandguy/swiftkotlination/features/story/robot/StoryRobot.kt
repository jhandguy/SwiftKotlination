package fr.jhandguy.swiftkotlination.features.story.robot

import android.app.Activity
import android.content.Intent.ACTION_VIEW
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.scrollTo
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.intent.Intents.intended
import androidx.test.espresso.intent.matcher.IntentMatchers.hasAction
import androidx.test.espresso.intent.matcher.IntentMatchers.hasData
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.robot.Robot
import org.hamcrest.CoreMatchers.allOf

class StoryRobot<T : Activity>(activityTestRule: ActivityTestRule<T>) : Robot<T>(activityTestRule) {

    fun checkStoryImage(): StoryRobot<T> {
        onView(withId(R.id.story_image))
            .check(matches(isDisplayed()))

        return this
    }

    fun checkStoryTitle(storyTitle: String): StoryRobot<T> {
        onView(withId(R.id.story_title))
            .check(matches(withText(storyTitle)))

        return this
    }

    fun checkStoryAbstract(storyAbstract: String): StoryRobot<T> {
        onView(withId(R.id.story_abstract))
            .check(matches(withText(storyAbstract)))

        return this
    }

    fun checkStoryByline(storyByline: String): StoryRobot<T> {
        onView(withId(R.id.story_byline))
            .check(matches(withText(storyByline)))

        return this
    }

    fun openChrome(): StoryRobot<T> {
        onView(withId(R.id.story_button))
            .perform(scrollTo(), click())

        return this
    }

    fun checkURL(url: String): StoryRobot<T> {
        val expectedIntent = allOf(hasAction(ACTION_VIEW), hasData(url))
        intended(expectedIntent)

        return this
    }
}
