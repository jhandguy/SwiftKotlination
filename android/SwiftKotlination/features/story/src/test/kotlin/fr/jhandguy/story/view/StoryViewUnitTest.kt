package fr.jhandguy.story.view

import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.R
import fr.jhandguy.story.application.StoryApp
import fr.jhandguy.story.coordinator.mocks.StoryCoordinatorMock
import fr.jhandguy.story.factory.mocks.StoryFactoryMock
import fr.jhandguy.story.model.Multimedia
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.mocks.StoryManagerMock
import fr.jhandguy.story.viewmodel.StoryViewModel
import fr.jhandguy.test.image.mocks.ImageManagerMock
import fr.jhandguy.test.network.File
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.sp
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertFalse
import kotlin.test.assertTrue
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
@LooperMode(PAUSED)
class StoryViewUnitTest {

    lateinit var sut: StoryView

    @Test
    fun `views are created correctly`() {
        val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = StoryCoordinatorMock()
        val factory = StoryFactoryMock(storyManager, imageManager, coordinator)
        val application = ApplicationProvider.getApplicationContext<StoryApp>()
        application.factory = factory

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.onActivity {
            val story = Story("section", "subsection", "title", "abstract", "url", "byline")
            val viewModel = StoryViewModel(factory, story)
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
        val storyManager = StoryManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val imageManager = ImageManagerMock(Result.Success(byteArray))
        val coordinator = StoryCoordinatorMock()
        val factory = StoryFactoryMock(storyManager, imageManager, coordinator)
        val application = ApplicationProvider.getApplicationContext<StoryApp>()
        application.factory = factory

        val scenario = ActivityScenario.launch(StoryActivity::class.java)
        scenario.onActivity {
            val story = Story("section", "subsection", "title", "abstract", "url", "byline", listOf(Multimedia("", Multimedia.Format.Large)))
            val viewModel = StoryViewModel(factory, story)
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
