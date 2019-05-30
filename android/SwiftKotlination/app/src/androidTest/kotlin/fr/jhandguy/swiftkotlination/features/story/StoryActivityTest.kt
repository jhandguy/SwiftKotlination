package fr.jhandguy.swiftkotlination.features.story

import android.content.Intent
import androidx.appcompat.widget.AppCompatTextView
import androidx.test.core.app.ApplicationProvider
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.intent.Intents
import androidx.test.espresso.intent.Intents.intended
import androidx.test.espresso.intent.matcher.IntentMatchers.hasAction
import androidx.test.espresso.intent.matcher.IntentMatchers.hasData
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import kotlinx.serialization.json.Json
import org.hamcrest.CoreMatchers
import org.hamcrest.Matchers.allOf
import org.junit.Rule
import org.junit.Test

class StoryActivityTest {
    @get:Rule
    val activityRule = ActivityTestRule(StoryActivity::class.java, false, false)

    @Test
    fun testStoryActivity() {
        val application = ApplicationProvider.getApplicationContext<AppMock>()
        application.responses = hashMapOf(
                Pair(Request.FetchImage("https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-superJumbo.jpg"), linkedListOf(
                        Response(File("28trump-endorsements1-superJumbo", File.Extension.JPG))
                ))
        )

        val story = Story(
                "U.S",
                "Politics",
                "A Trump Endorsement Can Decide a Race. Here’s How to Get One.",
                "The president’s grip on G.O.P. primary voters is as strong as it has been since he seized the party’s nomination.",
                "https://www.nytimes.com/2018/08/27/us/politics/trump-endorsements.html",
                "By JONATHAN MARTIN and MAGGIE HABERMAN",
                listOf(
                        Multimedia(
                                "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-thumbStandard.jpg",
                                Multimedia.Format.Icon
                        ),
                        Multimedia(
                                "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-thumbLarge.jpg",
                                Multimedia.Format.Small
                        ),
                        Multimedia(
                                "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-articleInline.jpg",
                                Multimedia.Format.Normal
                        ),
                        Multimedia(
                                "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-mediumThreeByTwo210.jpg",
                                Multimedia.Format.Medium
                        ),
                        Multimedia(
                                "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-superJumbo.jpg",
                                Multimedia.Format.Large
                        )
                )
        )

        val intent = Intent()
        intent.putExtra(Story::class.java.simpleName, Json.stringify(Story.serializer(), story))
        activityRule.launchActivity(intent)

        onView(CoreMatchers.instanceOf(AppCompatTextView::class.java))
                .check(matches(withText("${story.section} - ${story.subsection}")))

        onView(withId(R.id.story_image))
                .check(matches(isCompletelyDisplayed()))

        onView(withId(R.id.story_title))
                .check(matches(withText(story.title)))

        onView(withId(R.id.story_abstract))
                .check(matches(withText(story.abstract)))

        onView(withId(R.id.story_byline))
                .check(matches(withText(story.byline)))

        //TODO: Take Screenshot

        Intents.init()
        val expectedIntent = allOf(hasAction(Intent.ACTION_VIEW), hasData(story.url))

        onView(withId(R.id.story_button))
                .perform(click())

        intended(expectedIntent)
        Intents.release()
    }
}