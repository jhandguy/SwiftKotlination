package fr.jhandguy.swiftkotlination.features.topstories.view

import android.graphics.BitmapFactory
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.swiftkotlination.features.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.model.mocks.ImageManagerMock
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.observer.Result
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
class TopStoriesAdapterUnitTest {

    lateinit var sut: TopStoriesAdapter

    @Test
    fun `view holder is bound correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
                ?: fail("Expected ClassLoader to not be null")
            val byteArray = stream.readBytes()
            val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
            val imageManager = ImageManagerMock(Result.Success(bitmap))
            val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
            val viewModel = TopStoriesViewModel(factory)
            val coordinator = CoordinatorMock()
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