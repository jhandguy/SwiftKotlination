package fr.jhandguy.swiftkotlination.features.topstories

import android.content.Intent
import androidx.appcompat.widget.AppCompatTextView
import androidx.test.core.app.ApplicationProvider
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.Espresso.pressBack
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.swipeDown
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.withParent
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.matchers.RecyclerViewMatcher.Companion.childOfParent
import fr.jhandguy.swiftkotlination.matchers.RecyclerViewMatcher.Companion.withItemCount
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import org.hamcrest.CoreMatchers.allOf
import org.hamcrest.CoreMatchers.instanceOf
import org.junit.Before
import org.junit.ClassRule
import org.junit.Rule
import org.junit.Test
import tools.fastlane.screengrab.Screengrab
import tools.fastlane.screengrab.UiAutomatorScreenshotStrategy
import tools.fastlane.screengrab.locale.LocaleTestRule

class TopStoriesActivityTest {
    companion object {
        @get:ClassRule
        val localeTestRule = LocaleTestRule()
    }

    @get:Rule
    val activityRule = ActivityTestRule(TopStoriesActivity::class.java, false, false)

    @Before
    fun setUp() {
        Screengrab.setDefaultScreenshotStrategy(UiAutomatorScreenshotStrategy())
    }

    @Test
    fun testTopStoriesActivity() {
        val topStories = arrayListOf(
                Triple(
                    "Preliminary Nafta Deal Reached Between U.S. and Mexico",
                    "By ANA SWANSON and KATIE ROGERS",
                    "U.S. - Politics"
                ),
                Triple(
                        "Arizona Governor Faces a Tough Choice: A Senator Made From McCain’s Mold or Trump’s",
                        "By JONATHAN MARTIN",
                        "U.S."
                )
        )

        val application = ApplicationProvider.getApplicationContext<AppMock>()
        application.responses = hashMapOf(
                Pair(Request.FetchTopStories, linkedListOf(
                        Response(File("top_stories", File.Extension.JSON)),
                        Response(File("top_stories", File.Extension.JSON)),
                        Response(File("top_stories", File.Extension.JSON)),
                        Response(error = NetworkError.InvalidResponse())
                )),
                Pair(Request.FetchImage("https://static01.nyt.com/images/2018/08/27/us/28DC-nafta/28DC-nafta-thumbLarge.jpg"), linkedListOf(
                        Response(File("28DC-nafta-thumbLarge", File.Extension.JPG))
                )),
                Pair(Request.FetchImage("https://static01.nyt.com/images/2018/08/27/us/28DC-nafta/28DC-nafta-superJumbo-v2.jpg"), linkedListOf(
                        Response(File("28DC-nafta-superJumbo-v2", File.Extension.JPG))
                )),
                Pair(Request.FetchImage("https://static01.nyt.com/images/2018/08/27/us/27arizpolitics7/27arizpolitics7-thumbLarge.jpg"), linkedListOf(
                        Response(File("27arizpolitics7-thumbLarge", File.Extension.JPG))
                )),
                Pair(Request.FetchImage("https://static01.nyt.com/images/2018/08/27/us/27arizpolitics7/27arizpolitics7-superJumbo-v2.jpg"), linkedListOf(
                        Response(File("27arizpolitics7-superJumbo-v2", File.Extension.JPG))
                ))
        )

        activityRule.launchActivity(Intent())

        onView(instanceOf(AppCompatTextView::class.java))
                .check(matches(withText("Top Stories")))

        Screengrab.screenshot("top-stories")

        onView(withId(R.id.top_stories_list))
                .check(matches(withItemCount(2)))

        topStories.forEachIndexed { index, story ->
            onView(allOf(
                    withParent(childOfParent(withId(R.id.top_stories_list), index)),
                    withId(R.id.top_stories_item_title)
            ))
                    .check(matches(withText(story.first)))

            onView(allOf(
                    withParent(childOfParent(withId(R.id.top_stories_list), index)),
                    withId(R.id.top_stories_item_byline)
            ))
                    .check(matches(withText(story.second)))

            onView(childOfParent(withId(R.id.top_stories_list), index))
                    .perform(click())

            onView(instanceOf(AppCompatTextView::class.java))
                    .check(matches(withText(story.third)))

            pressBack()
        }

        onView(instanceOf(AppCompatTextView::class.java))
                .check(matches(withText("Top Stories")))

        onView(withId(R.id.top_stories_list))
                .check(matches(withItemCount(2)))

        onView(withId(R.id.top_stories_list))
                .perform(swipeDown())
    }
}