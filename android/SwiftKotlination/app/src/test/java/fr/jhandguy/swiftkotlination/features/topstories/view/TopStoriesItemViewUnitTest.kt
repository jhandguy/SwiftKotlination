package fr.jhandguy.swiftkotlination.features.topstories.view

import android.app.Activity
import android.support.constraint.ConstraintLayout
import android.view.View
import android.widget.Button
import android.widget.TextView
import fr.jhandguy.swiftkotlination.R
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.jetbrains.anko.AnkoContext.Companion.create
import org.jetbrains.anko.childrenSequence
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.robolectric.Robolectric.setupActivity
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class TopStoriesItemViewUnitTest {

    lateinit var view: View

    @Before
    fun before() {
        view = TopStoriesItemView().createView(create(setupActivity(Activity::class.java)))
    }

    @Test
    fun `top stories item view is created`() {
        with(view) {
            assert(this is ConstraintLayout)
            assertEquals(childrenSequence().count(), 3)

            with(find<TextView>(R.id.top_stories_item_title)) {
                assertNotNull(this)
            }

            with(find<TextView>(R.id.top_stories_item_byline)) {
                assertNotNull(this)
            }

            with(find<Button>(R.id.top_stories_item_button)) {
                assertNotNull(this)
            }
        }
    }

    @After
    fun after() {
        closeKoin()
    }
}