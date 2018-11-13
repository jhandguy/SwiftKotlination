package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result
import junit.framework.Assert.assertEquals
import junit.framework.Assert.fail
import kotlinx.coroutines.runBlocking
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class TopStoriesViewModelUnitTest {

    @Mock
    lateinit var topStoriesManager: TopStoriesManagerInterface

    @Mock
    lateinit var topStoriesFactory: TopStoriesFactory

    lateinit var sut: TopStoriesViewModel

    @Before
    fun before() {
        whenever(topStoriesFactory.makeTopStoriesManager())
                .thenReturn(topStoriesManager)
        sut = TopStoriesViewModel(topStoriesFactory)
    }

    @Test
    fun `top stories are fetched correctly`() {
        val topStories = TopStories(
                results = listOf(
                    Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                    Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
                )
        )

        runBlocking {
            whenever(topStoriesManager.topStories(any())).thenAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<TopStories>
                observer?.invoke(Result.Success(topStories))
            }

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

        runBlocking {
            whenever(topStoriesManager.topStories(any())).thenAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<TopStories>
                observer?.invoke(Result.Failure(error))
            }

            sut.topStories { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }
}