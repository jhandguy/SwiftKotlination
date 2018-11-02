package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.whenever
import fr.jhandguy.swiftkotlination.Result
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import junit.framework.Assert.assertEquals
import junit.framework.Assert.fail
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.StandAloneContext.stopKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class TopStoriesViewModelUnitTest: KoinTest {

    @Mock
    lateinit var repository: TopStoriesRepository

    val viewModel: TopStoriesViewModel by inject()

    @Before
    fun before() {
        startKoin(listOf(
                module {
                    factory { TopStoriesViewModel(repository) }
                }
        ))
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
            whenever(repository.topStories(any())).thenAnswer {
                val observer = it.arguments.first() as? (Result<TopStories>) -> Unit
                observer?.invoke(Result.Success(topStories))
            }

            viewModel.topStories { result ->
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
            whenever(repository.topStories(any())).thenAnswer {
                val observer = it.arguments.first() as? (Result<TopStories>) -> Unit
                observer?.invoke(Result.Failure(error))
            }

            viewModel.topStories { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }

    @After
    fun after() {
        stopKoin()
    }
}