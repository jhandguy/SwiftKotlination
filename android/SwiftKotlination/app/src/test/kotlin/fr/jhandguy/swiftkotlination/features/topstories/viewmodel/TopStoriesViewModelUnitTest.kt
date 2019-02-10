package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import android.graphics.BitmapFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.features.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.swiftkotlination.model.mocks.ImageManagerMock
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotNull
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
class TopStoriesViewModelUnitTest {

    lateinit var sut: TopStoriesViewModel

    @Test
    fun `top stories are fetched correctly`() {
        val topStories = TopStories(
                results = listOf(
                    Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                    Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
                )
        )
        val topStoriesManager = TopStoriesManagerMock(
                Result.Success(topStories)
        )
        val imageManager = ImageManagerMock(
                Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.topStories { result ->
                when (result) {
                    is Result.Success -> assertEquals(result.data, topStories.results)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `top stories are refreshed correctly`() {
        val topStories = TopStories(
            results = listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
            )
        )
        val topStoriesManager = TopStoriesManagerMock(
            Result.Success(topStories)
        ) { result ->
            when (result) {
                is Result.Success -> assertEquals(result.data, topStories)
                is Result.Failure -> fail(result.error.message)
            }
        }
        val imageManager = ImageManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.refresh()
        }
    }

    @Test
    fun `image is fetched correctly`() {
        val topStoriesManager = TopStoriesManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val imageManager = ImageManagerMock(
            Result.Success(bitmap)
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> {
                        assert(result.data.sameAs(bitmap))
                        assertNotNull(sut.images[""])
                    }
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `image is fetched from cache correctly`() {
        val topStoriesManager = TopStoriesManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val imageManager = ImageManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        sut.images[""] = bitmap

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> assert(result.data.sameAs(bitmap))
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error fetching top stories is thrown correctly`() {
        val error = Error("Error fetching top stories: 404 - Response.error()")
        val topStoriesManager = TopStoriesManagerMock(
                Result.Failure(error)
        )
        val imageManager = ImageManagerMock(
                Result.Failure(NetworkError.InvalidResponse())
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.topStories { result ->
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
        val topStoriesManager = TopStoriesManagerMock(
            Result.Failure(NetworkError.InvalidResponse())
        )
        val imageManager = ImageManagerMock(
            Result.Failure(error)
        )
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
        sut = TopStoriesViewModel(factory)

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