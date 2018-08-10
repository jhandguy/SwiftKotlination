package fr.jhandguy.swiftkotlination.features.story.view

import android.content.Intent
import android.widget.TextView
import com.nhaarman.mockito_kotlin.verify
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.contentView
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.test.KoinTest
import org.koin.test.declare
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.buildActivity
import org.robolectric.RobolectricTestRunner
import org.robolectric.android.controller.ActivityController

@RunWith(RobolectricTestRunner::class)
class StoryActivityUnitTest: KoinTest {

    lateinit var activityController: ActivityController<StoryActivity>

    val story = Story("section", "subsection", "title", "abstract", "url", "byline")

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        declare {
            factory(override = true) { coordinator }
        }
        val intent = Intent()
        intent.putExtra(Story::class.java.simpleName, story)
        activityController = buildActivity(StoryActivity::class.java, intent)
    }

    @Test
    fun `story activity starts`() {
        with(activityController.create().get()) {
            assertNotEquals(view.story, story)
            assertNull(contentView)
        }

        with(activityController.start().get()) {
            contentView?.let {

                assertNotNull(it.find<TextView>(R.id.story_title))
                assertNotNull(it.find<TextView>(R.id.story_abstract))
                assertNotNull(it.find<TextView>(R.id.story_byline))
                assertNotNull(it.find<TextView>(R.id.story_button))
            } ?: fail("ContentView should not be null")

            assertEquals(view.story, story)
        }
    }

    @Test
    fun `story activity finishes`() {
        with(activityController.get()) {
            assert(onSupportNavigateUp())
        }

        verify(coordinator).finish()
    }

    @After
    fun after() {
        closeKoin()
    }
}