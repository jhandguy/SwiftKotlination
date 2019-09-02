package fr.jhandguy.swiftkotlination.features.story.view

import android.graphics.BitmapFactory
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.story.factory.mocks.StoryFactoryMock
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.mocks.StoryManagerMock
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.model.mocks.ImageManagerMock
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.observer.Result
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue
import kotlin.test.fail
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.sp
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED

@RunWith(RobolectricTestRunner::class)
@LooperMode(PAUSED)
class StoryViewUnitTest {

    lateinit var sut: StoryView

    @Test
    fun `views are created correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val factory = StoryFactoryMock(storyManager, imageManager)
            val story = Story("section", "subsection", "title", "abstract", "url", "byline")
            val viewModel = StoryViewModel(factory, story)
            val coordinator = CoordinatorMock()
            sut = StoryView(it, viewModel, coordinator, story = story)

            val context = AnkoContext.create(it)
            val view = sut.createView(context)

            view.find<ImageView>(R.id.story_image).run {
                assertTrue(adjustViewBounds)
                assertEquals(visibility, View.GONE)
            }

            view.find<TextView>(R.id.story_title).run {
                assertEquals(text, story.title)
                assertEquals(currentTextColor, it.getColor(R.color.primary_text))
                assertEquals(textSize, sp(10).toFloat())
            }

            view.find<TextView>(R.id.story_abstract).run {
                assertEquals(text, story.abstract)
                assertEquals(currentTextColor, it.getColor(R.color.primary_text))
                assertEquals(textSize, sp(6).toFloat())
            }

            view.find<TextView>(R.id.story_byline).run {
                assertEquals(text, story.byline)
                assertEquals(currentTextColor, it.getColor(R.color.secondary_text))
                assertEquals(textSize, sp(4).toFloat())
            }

            view.find<Button>(R.id.story_button).run {
                assertEquals(text, it.getString(R.string.story_button_title))
                assertFalse(isAllCaps)
                assertEquals(textSize, sp(6).toFloat())
                assertEquals(currentTextColor, it.getColor(R.color.accent))
                performClick()
                assert(coordinator.isUrlOpen)
            }
        }
    }

    @Test
    fun `image is displayed correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
                ?: fail("Expected ClassLoader to not be null")
            val byteArray = stream.readBytes()
            val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
            val imageManager = ImageManagerMock(Result.Success(bitmap))
            val factory = StoryFactoryMock(storyManager, imageManager)
            val story = Story("section", "subsection", "title", "abstract", "url", "byline", listOf(Multimedia("", Multimedia.Format.Large)))
            val viewModel = StoryViewModel(factory, story)
            val coordinator = CoordinatorMock()
            sut = StoryView(it, viewModel, coordinator, story = story)

            val context = AnkoContext.create(it)
            val view = sut.createView(context)

            view.find<ImageView>(R.id.story_image).run {
                assertTrue(adjustViewBounds)
                assertEquals(visibility, View.VISIBLE)
            }
        }
    }
}
