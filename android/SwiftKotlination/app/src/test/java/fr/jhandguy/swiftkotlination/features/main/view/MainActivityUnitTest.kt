package fr.jhandguy.swiftkotlination.features.main.view

import com.nhaarman.mockito_kotlin.verify
import fr.jhandguy.swiftkotlination.Coordinator
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.StandAloneContext.loadKoinModules
import org.koin.test.KoinTest
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.setupActivity
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class MainActivityUnitTest: KoinTest {

    lateinit var activity: MainActivity

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        loadKoinModules(
                module {
                    factory(override = true) { coordinator }
                }
        )
        activity = setupActivity(MainActivity::class.java)
    }

    @Test
    fun `main activity starts`() {
        verify(coordinator).start()
    }

    @After
    fun after() {
        closeKoin()
    }
}