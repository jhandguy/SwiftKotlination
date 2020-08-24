package fr.jhandguy.swiftkotlination.view

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario.launch
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.swiftkotlination.application.App
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.factory.mocks.DependencyManagerMock
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
@LooperMode(PAUSED)
class MainActivityUnitTest {

    @Test
    fun `coordinator is started correctly`() {
        val coordinator = CoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<App>()
        application.factory = DependencyManagerMock(coordinator = coordinator)

        val scenario = launch(MainActivity::class.java)
        scenario.moveToState(Lifecycle.State.STARTED)

        assert(coordinator.isStarted)
    }
}
