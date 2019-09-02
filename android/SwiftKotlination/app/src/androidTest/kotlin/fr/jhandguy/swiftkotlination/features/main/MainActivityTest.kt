package fr.jhandguy.swiftkotlination.features.main

import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.Responses
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.topstories.robot.TopStoriesRobot
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import fr.jhandguy.swiftkotlination.robot.checkTitle
import fr.jhandguy.swiftkotlination.robot.start
import org.junit.Rule
import org.junit.Test

class MainActivityTest {

    @get:Rule
    val activityRule = ActivityTestRule(MainActivity::class.java, false, false)

    @Test
    fun testMainActivity() {
        val responses: Responses = hashMapOf(
                Pair(Request.FetchTopStories, linkedListOf(
                        Response(File("top_stories_empty", File.Extension.JSON))
                ))
        )

        TopStoriesRobot(activityRule)
                .start(responses)
                .checkTitle("Top Stories")
    }
}
