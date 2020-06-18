package fr.jhandguy.swiftkotlination.features.story.viewmodel

import android.graphics.BitmapFactory
import fr.jhandguy.swiftkotlination.features.story.factory.mocks.StoryFactoryMock
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.mocks.StoryManagerMock
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.model.mocks.ImageManagerMock
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotNull
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
@LooperMode(PAUSED)
class StoryViewModelUnitTest {

    lateinit var sut: StoryViewModel

    @Test
    fun `story is fetched correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")
        val storyManager = StoryManagerMock(
            Result.Success(story)
        )
        val imageManager = ImageManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = StoryFactoryMock(storyManager, imageManager)
        sut = StoryViewModel(factory)

        runBlocking {
            sut.story { result ->
                when (result) {
                    is Result.Success -> assertEquals(result.data, story)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `image is fetched correctly`() {
        val storyManager = StoryManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val imageManager = ImageManagerMock(
            Result.Success(bitmap)
        )
        val factory = StoryFactoryMock(storyManager, imageManager)
        sut = StoryViewModel(factory)

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> {
                        assert(result.data.sameAs(bitmap))
                        assertNotNull(sut.image)
                    }
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `image is fetched from cache correctly`() {
        val storyManager = StoryManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val imageManager = ImageManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = StoryFactoryMock(storyManager, imageManager)
        sut = StoryViewModel(factory)

        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        sut.image = bitmap

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> result.data.sameAs(bitmap)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error fetching story is thrown correctly`() {
        val error = Error("Error fetching story: 404 - Response.error()")
        val storyManager = StoryManagerMock(
            Result.Failure(error)
        )
        val imageManager = ImageManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = StoryFactoryMock(storyManager, imageManager)
        sut = StoryViewModel(factory)

        runBlocking {
            sut.story { result ->
                when (result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }

    @Test
    fun `error fetching image is thrown correctly`() {
        val error = Error("Error fetching image: 404 - Response.error()")
        val storyManager = StoryManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val imageManager = ImageManagerMock(
            Result.Failure(error)
        )
        val factory = StoryFactoryMock(storyManager, imageManager)
        sut = StoryViewModel(factory)

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }
}
