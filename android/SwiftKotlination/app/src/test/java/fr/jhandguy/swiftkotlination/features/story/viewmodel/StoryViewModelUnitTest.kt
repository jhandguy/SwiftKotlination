package fr.jhandguy.swiftkotlination.features.story.viewmodel

import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.doAnswer
import com.nhaarman.mockitokotlin2.whenever
import fr.jhandguy.swiftkotlination.Result
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
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
class StoryViewModelUnitTest: KoinTest {

    @Mock
    lateinit var repository: StoryRepository

    val viewModel: StoryViewModel by inject()

    @Before
    fun before() {
        startKoin(listOf(
                module {
                    factory { StoryViewModel(repository) }
                }
        ))
    }

    @Test
    fun `story is fetched correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")

        runBlocking {
            whenever(repository.story(any())).doAnswer {
                val observer = it.arguments.first() as? (Result<Story>) -> Unit
                observer?.invoke(Result.Success(story))
            }

            viewModel.story { result ->
                when(result) {
                    is Result.Success -> assertEquals(result.data, story)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("error message")

        runBlocking {
            whenever(repository.story(any())).doAnswer {
                val observer = it.arguments.first() as? (Result<Story>) -> Unit
                observer?.invoke(Result.Failure(error))
            }

            viewModel.story { result ->
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