package fr.jhandguy.story.view

import androidx.appcompat.app.ActionBar
import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.application.StoryApp
import fr.jhandguy.story.coordinator.mocks.StoryCoordinatorMock
import fr.jhandguy.story.factory.mocks.StoryFactoryMock
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.mocks.StoryManagerMock
import fr.jhandguy.test.image.mocks.ImageManagerMock
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
class StoryActivityUnitTest {

    @Test
    fun `support action bar display options are set correctly`() {
        val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = StoryCoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<StoryApp>()
        application.factory = StoryFactoryMock(storyManager, imageManager, coordinator)

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
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = StoryCoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<StoryApp>()
        application.factory = StoryFactoryMock(storyManager, imageManager, coordinator)

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.moveToState(Lifecycle.State.STARTED)
        scenario.onActivity {
            assertEquals(it.title, "${story.section} - ${story.subsection}")
        }
    }

    @Test
    fun `coordinator is finished correctly`() {
        val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = StoryCoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<StoryApp>()
        application.factory = StoryFactoryMock(storyManager, imageManager, coordinator)

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.onActivity {
            it.onSupportNavigateUp()
            assert(coordinator.isFinished)
        }
    }
}
