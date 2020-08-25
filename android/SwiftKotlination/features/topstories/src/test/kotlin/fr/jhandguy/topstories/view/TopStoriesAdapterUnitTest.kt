package fr.jhandguy.topstories.view

import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.model.Multimedia
import fr.jhandguy.story.model.Story
import fr.jhandguy.test.image.mocks.ImageManagerMock
import fr.jhandguy.test.network.File
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.application.TopStoriesApp
import fr.jhandguy.topstories.coordinator.mocks.TopStoriesCoordinatorMock
import fr.jhandguy.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
class TopStoriesAdapterUnitTest {

    lateinit var sut: TopStoriesAdapter

    @Test
    fun `view holder is bound correctly`() {
        val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val imageManager = ImageManagerMock(Result.Success(byteArray))
        val coordinator = TopStoriesCoordinatorMock()
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager, coordinator)
        val application = ApplicationProvider.getApplicationContext<TopStoriesApp>()
        application.factory = factory

        val scenario = ActivityScenario.launch(TopStoriesActivity::class.java)
        scenario.onActivity {
            val viewModel = TopStoriesViewModel(factory)
            sut = TopStoriesAdapter(it, viewModel, coordinator)

            val context = AnkoContext.create(it)
            val itemView = TopStoriesItemView().createView(context)
            val viewHolder = TopStoriesAdapter.ViewHolder(itemView, coordinator)

            val story = Story("section", "subsection", "title", "abstract", "url", "byline", listOf(Multimedia("", Multimedia.Format.Small)))
            viewModel.stories = listOf(story)
            sut.onBindViewHolder(viewHolder, 0)

            itemView.find<ImageView>(R.id.top_stories_item_image).run {
                assertEquals(visibility, View.VISIBLE)
            }

            itemView.find<TextView>(R.id.top_stories_item_title).run {
                assertEquals(text, story.title)
            }

            itemView.find<TextView>(R.id.top_stories_item_byline).run {
                assertEquals(text, story.byline)
            }

            itemView.performClick()

            assert(coordinator.isStoryOpen)
        }
    }
}
