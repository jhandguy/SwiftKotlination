package fr.jhandguy.swiftkotlination.features.story.view

import android.app.Activity
import android.support.constraint.ConstraintLayout
import android.view.View
import android.widget.Button
import android.widget.TextView
import com.nhaarman.mockito_kotlin.verify
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import junit.framework.Assert
import junit.framework.Assert.assertEquals
import org.jetbrains.anko.AnkoContext.Companion.create
import org.jetbrains.anko.childrenSequence
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.setupActivity
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class StoryViewUnitTest {

    lateinit var view: View

    val story = Story("section","subsection","title","abstract","https://url.com","byline")

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        view = StoryView(coordinator, story)
                .createView(create(setupActivity(Activity::class.java)))
    }

    @Test
    fun `story view is created`() {
        with(view) {
            assert(this is ConstraintLayout)
            assertEquals(childrenSequence().count(), 4)

            with(find<TextView>(R.id.story_title)) {
                Assert.assertNotNull(this)
                assertEquals(text, story.title)
            }

            with(find<TextView>(R.id.story_abstract)) {
                Assert.assertNotNull(this)
                assertEquals(text, story.abstract)
            }

            with(find<TextView>(R.id.story_byline)) {
                Assert.assertNotNull(this)
                assertEquals(text, story.byline)
            }

            with(find<Button>(R.id.story_button)) {
                Assert.assertNotNull(this)
                assertEquals(text, resources.getString(R.string.story_button_title))
                assert(callOnClick())
            }
        }
    }

    @Test
    fun `coordinator opens story url`() {
        with(view.find<Button>(R.id.story_button)) {
            assert(callOnClick())
        }

        verify(coordinator).open(story.url)
    }

    @After
    fun after() {
        closeKoin()
    }
}