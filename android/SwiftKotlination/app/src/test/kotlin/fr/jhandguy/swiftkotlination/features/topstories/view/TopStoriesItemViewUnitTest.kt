package fr.jhandguy.swiftkotlination.features.topstories.view

import android.graphics.Typeface
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.sp
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@LooperMode(PAUSED)
class TopStoriesItemViewUnitTest {

    lateinit var sut: TopStoriesItemView

    @Test
    fun `views are created correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            sut = TopStoriesItemView()

            val context = AnkoContext.create(it)
            val view = sut.createView(context)

            view.find<ImageView>(R.id.top_stories_item_image).run {
                assertEquals(visibility, View.VISIBLE)
            }

            view.find<TextView>(R.id.top_stories_item_title).run {
                assertEquals(textSize, sp(6).toFloat())
                assertEquals(typeface, Typeface.DEFAULT_BOLD)
            }

            view.find<TextView>(R.id.top_stories_item_byline).run {
                assertEquals(textSize, sp(5).toFloat())
            }
        }
    }
}
