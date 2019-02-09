package fr.jhandguy.swiftkotlination.coordinator

import android.app.Activity
import android.content.Intent
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
class CoordinatorUnitTest {

    lateinit var sut: Coordinator

    @BeforeTest
    fun setup() {
        val scenario = ActivityScenario.launch(Activity::class.java)
        scenario.onActivity {
            sut = Coordinator(it)
        }
    }

    @Test
    fun `top stories activity is started correctly`() {
        val intent = sut.start()
        assertEquals(intent.component?.className, TopStoriesActivity::class.java.name)
    }

    @Test
    fun `story activity is started correctly`() {
        val story = Story()
        val intent = sut.open(story)
        assertEquals(intent.component?.className, StoryActivity::class.java.name)
    }

    @Test
    fun `is started correctly`() {
        val url = "https://url.com"
        val intent = sut.open(url)
        assertEquals(intent.action, Intent.ACTION_VIEW)
        assertEquals(intent.dataString, url)
    }
}