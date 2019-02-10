package fr.jhandguy.swiftkotlination.features.story.view

import androidx.appcompat.app.ActionBar
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.factory.mocks.DependencyManagerMock
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.mocks.StoryManagerMock
import fr.jhandguy.swiftkotlination.observer.Result
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
class StoryActivityUnitTest {

    @Test
    fun `support action bar display options are set correctly`() {
        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.moveToState(Lifecycle.State.CREATED)
        scenario.onActivity {
            assertEquals(it.supportActionBar?.displayOptions, ActionBar.DISPLAY_SHOW_TITLE + ActionBar.DISPLAY_SHOW_HOME + ActionBar.DISPLAY_HOME_AS_UP)
        }
    }

    @Test
    fun `title is set correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")
        val storyManager = StoryManagerMock(Result.Success(story))
        val application = ApplicationProvider.getApplicationContext<App>()
        application.factory = DependencyManagerMock(storyManager = storyManager)

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.moveToState(Lifecycle.State.STARTED)
        scenario.onActivity {
            assertEquals(it.title, "${story.section} - ${story.subsection}")
        }
    }

    @Test
    fun `coordinator is finished correctly`() {
        val coordinator = CoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<App>()
        application.factory = DependencyManagerMock(coordinator = coordinator)

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.onActivity {
            it.onSupportNavigateUp()
            assert(coordinator.isFinished)
        }
    }
}