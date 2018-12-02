package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.network.mocks.NetworkManagerMock
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.JSON
import kotlin.test.assertEquals
import kotlin.test.fail
import kotlin.test.Test

class TopStoriesManagerUnitTest {

    lateinit var sut: TopStoriesManager

    @Test
    fun `top stories are observed correctly`() {
        val topStories = TopStories(listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        ))
        val data = JSON.stringify(TopStories.serializer(), topStories).toByteArray()
        val networkManager = NetworkManagerMock(Result.Success(data))
        sut = TopStoriesManager(networkManager)

        runBlocking {
            sut.topStories { result ->
                when(result) {
                    is Result.Success -> assertEquals(result.data, topStories)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `top stories are observed and fetched correctly`() {
        val topStories = TopStories(listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        ))
        val data = JSON.stringify(TopStories.serializer(), topStories).toByteArray()
        val networkManager = NetworkManagerMock(Result.Success(data))

        sut = TopStoriesManager(networkManager)

        runBlocking {
            var times = 0

            sut.topStories { result ->
                when(result) {
                    is Result.Success -> assertEquals(result.data, topStories)
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }

            assertEquals(times, 1)

            sut.fetchStories()

            assertEquals(times, 2)
        }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("Error fetching top stories: 404 - Response.error()")
        val networkManager = NetworkManagerMock(Result.Failure(error))
        sut = TopStoriesManager(networkManager)

        runBlocking {
            sut.topStories { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error.message, error.message)
                }
            }
        }
    }
}