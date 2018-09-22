package fr.jhandguy.swiftkotlination.features.main.view

import com.nhaarman.mockito_kotlin.never
import com.nhaarman.mockito_kotlin.verify
import fr.jhandguy.swiftkotlination.Coordinator
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.stopKoin
import org.koin.test.KoinTest
import org.koin.test.declare
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.buildActivity
import org.robolectric.RobolectricTestRunner
import org.robolectric.android.controller.ActivityController

@RunWith(RobolectricTestRunner::class)
class MainActivityUnitTest: KoinTest {

    lateinit var activityController: ActivityController<MainActivity>

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        declare {
            factory(override = true) { coordinator }
        }
        activityController = buildActivity(MainActivity::class.java)
    }

    @Test
    fun `main activity starts`() {
        activityController.create()
        verify(coordinator, never()).start()

        activityController.start()
        verify(coordinator).start()
    }

    @After
    fun after() {
        stopKoin()
    }
}