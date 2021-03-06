package fr.jhandguy.topstories.view

import android.graphics.Typeface
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.test.image.mocks.ImageManagerMock
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.application.TopStoriesApp
import fr.jhandguy.topstories.coordinator.mocks.TopStoriesCoordinatorMock
import fr.jhandguy.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.topstories.model.mocks.TopStoriesManagerMock
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.sp
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
class TopStoriesItemViewUnitTest {

    lateinit var sut: TopStoriesItemView

    @Test
    fun `views are created correctly`() {
        val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = TopStoriesCoordinatorMock()
        val application = ApplicationProvider.getApplicationContext<TopStoriesApp>()
        application.factory = TopStoriesFactoryMock(topStoriesManager, imageManager, coordinator)

        val scenario = ActivityScenario.launch(TopStoriesActivity::class.java)
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
