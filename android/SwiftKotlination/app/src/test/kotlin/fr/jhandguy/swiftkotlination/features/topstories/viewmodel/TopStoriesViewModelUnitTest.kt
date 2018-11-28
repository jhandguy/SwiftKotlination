package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.features.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.fail
import org.junit.Test

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
        val manager = TopStoriesManagerMock(
                Result.Success(topStories)
        )
        val factory = TopStoriesFactoryMock(manager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.topStories { result ->
                when(result) {
                    is Result.Success -> assertEquals(result.data, topStories.results)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("error message")
        val manager = TopStoriesManagerMock(
                Result.Failure(error)
        )
        val factory = TopStoriesFactoryMock(manager)
        sut = TopStoriesViewModel(factory)

        runBlocking {
            sut.topStories { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }
}