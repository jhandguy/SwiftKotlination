package fr.jhandguy.topstories.view

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.test.image.mocks.ImageManagerMock
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.application.TopStoriesApp
import fr.jhandguy.topstories.coordinator.mocks.TopStoriesCoordinatorMock
import fr.jhandguy.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.topstories.model.mocks.TopStoriesManagerMock
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
@LooperMode(PAUSED)
class TopStoriesActivityUnitTest {

    @Test
    fun `title is set correctly`() {
        val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = TopStoriesCoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<TopStoriesApp>()
        application.factory = TopStoriesFactoryMock(topStoriesManager, imageManager, coordinator)

        val scenario = ActivityScenario.launch(TopStoriesActivity::class.java)
        scenario.moveToState(Lifecycle.State.CREATED)
        scenario.onActivity {
            assertEquals(it.title, it.getString(R.string.top_stories_title))
        }
    }
}
