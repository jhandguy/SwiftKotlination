package fr.jhandguy.swiftkotlination.features.topstories

import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.Responses
import fr.jhandguy.swiftkotlination.features.topstories.robot.TopStoriesRobot
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import fr.jhandguy.swiftkotlination.global.linkedListOf
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.network.Response
import fr.jhandguy.swiftkotlination.robot.back
import fr.jhandguy.swiftkotlination.robot.checkAlert
import fr.jhandguy.swiftkotlination.robot.checkTitle
import fr.jhandguy.swiftkotlination.robot.closeAlert
import fr.jhandguy.swiftkotlination.robot.start
import fr.jhandguy.swiftkotlination.robot.takeScreenshot
import org.junit.ClassRule
import org.junit.Rule
import org.junit.Test
import tools.fastlane.screengrab.locale.LocaleTestRule

class TopStoriesActivityTest {

    companion object {
        @get:ClassRule
        val localeTestRule = LocaleTestRule()
    }

    @get:Rule
    val activityRule = ActivityTestRule(TopStoriesActivity::class.java, false, false)

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

        val responses: Responses = hashMapOf(
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

        TopStoriesRobot(activityRule)
                .start(responses)
                .checkTitle("Top Stories")
                .takeScreenshot("top-stories")
                .checkTopStoriesCount(topStories.count())
                .forEachTopStories(listOf(0, 1)) { robot, index ->
                    val story = topStories[index]
                    robot
                            .checkTopStoryTitle(story.first, index)
                            .checkTopStoryByline(story.second, index)
                            .openStory(index)
                            .checkTitle(story.third)
                            .back()
                }
                .checkTitle("Top Stories")
                .checkTopStoriesCount(topStories.count())
                .refreshTopStories()
                .checkAlert(NetworkError.InvalidResponse())
                .closeAlert()
    }
}
