package fr.jhandguy.swiftkotlination.features.topstories.view

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.R
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
class TopStoriesActivityUnitTest {

    @Test
    fun `title is set correctly`() {
        val scenario = ActivityScenario.launch(TopStoriesActivity::class.java)
        scenario.moveToState(Lifecycle.State.CREATED)
        scenario.onActivity {
            assertEquals(it.title, it.getString(R.string.top_stories_title))
        }
    }
}