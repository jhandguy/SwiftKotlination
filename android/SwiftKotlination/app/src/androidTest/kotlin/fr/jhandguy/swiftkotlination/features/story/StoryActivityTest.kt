package fr.jhandguy.swiftkotlination.features.story

import android.content.Intent
import androidx.test.core.app.ApplicationProvider
import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.AppMock
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import kotlinx.serialization.json.Json
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
                "By JONATHAN MARTIN and MAGGIE HABERMAN",
                "https://www.nytimes.com/2018/08/27/us/politics/trump-endorsements.html",
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
    }
}