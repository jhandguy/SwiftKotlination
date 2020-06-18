package fr.jhandguy.swiftkotlination.presenter

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.network.NetworkError
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import org.robolectric.shadows.ShadowAlertDialog
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@LooperMode(PAUSED)
class ErrorPresenterUnitTest {

    lateinit var sut: ErrorPresenter

    @BeforeTest
    fun before() {
        sut = ErrorPresenter(NetworkError.InvalidRequest())
    }

    @Test
    fun `error is presented correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.moveToState(Lifecycle.State.STARTED)

        scenario.onActivity {
            sut.presentIn(it)

            val dialogs = ShadowAlertDialog.getShownDialogs()
            assertEquals(dialogs.count(), 1)
        }
    }
}
