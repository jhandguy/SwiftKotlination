package fr.jhandguy.swiftkotlination.features.main.view

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario.launch
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.factory.mocks.DependencyManagerMock
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test

@RunWith(RobolectricTestRunner::class)
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