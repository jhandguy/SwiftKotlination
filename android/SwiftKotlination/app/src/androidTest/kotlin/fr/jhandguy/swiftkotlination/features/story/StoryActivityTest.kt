package fr.jhandguy.swiftkotlination.features.story

import android.os.Bundle
import androidx.test.espresso.intent.rule.IntentsTestRule
import fr.jhandguy.network.model.network.Request
import fr.jhandguy.story.model.Multimedia
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.application.Responses
import fr.jhandguy.swiftkotlination.features.story.robot.StoryRobot
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.robot.checkTitle
import fr.jhandguy.swiftkotlination.robot.start
import fr.jhandguy.swiftkotlination.robot.takeScreenshot
import fr.jhandguy.test.network.File
import fr.jhandguy.test.network.Response
import kotlinx.serialization.json.Json
import org.junit.ClassRule
import org.junit.Rule
import org.junit.Test
import tools.fastlane.screengrab.locale.LocaleTestRule

class StoryActivityTest {

    companion object {
        @get:ClassRule
        val localeTestRule = LocaleTestRule()
    }

    @get:Rule
    val activityRule = IntentsTestRule(StoryActivity::class.java, false, false)

    @Test
    fun testStoryActivity() {
        val responses: Responses = hashMapOf(
            Pair(
                Request.FetchImage("https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-superJumbo.jpg"),
                linkedListOf(
                    Response(File("28trump-endorsements1-superJumbo", File.Extension.JPG))
                )
            )
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

        val extras = Bundle()
        extras.putString(Story::class.java.simpleName, Json.encodeToString(Story.serializer(), story))

        StoryRobot(activityRule)
            .start(responses, extras)
            .checkTitle("${story.section} - ${story.subsection}")
            .takeScreenshot("story")
            .checkStoryImage()
            .checkStoryTitle(story.title)
            .checkStoryAbstract(story.abstract)
            .checkStoryByline(story.byline)
            .openChrome()
            .checkURL(story.url)
    }
}
