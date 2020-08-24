package fr.jhandguy.extension.presenter

import androidx.lifecycle.Lifecycle
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.extension.view.ActivityMock
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import org.robolectric.shadows.ShadowAlertDialog
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
@LooperMode(PAUSED)
class ErrorPresenterUnitTest {

    internal lateinit var sut: ErrorPresenter

    private sealed class ErrorMock : Error() {
        class SomethingWentWrong : ErrorMock()

        override val message: String
            get() = when (this) {
                is SomethingWentWrong -> "Something went wrong, please try again later."
            }
    }

    @BeforeTest
    fun before() {
        sut = ErrorPresenter(ErrorMock.SomethingWentWrong())
    }

    @Test
    fun `error is presented correctly`() {
        val scenario = ActivityScenario.launch(ActivityMock::class.java)
        scenario.moveToState(Lifecycle.State.STARTED)

        scenario.onActivity {
            sut.presentIn(it)

            val dialogs = ShadowAlertDialog.getShownDialogs()
            assertEquals(dialogs.count(), 1)
        }
    }
}
