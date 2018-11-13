package fr.jhandguy.swiftkotlination.features.story.viewmodel

import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.doAnswer
import com.nhaarman.mockitokotlin2.whenever
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
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
class StoryViewModelUnitTest {

    @Mock
    lateinit var manager: StoryManagerInterface

    @Mock
    lateinit var factory: StoryFactory

    lateinit var sut: StoryViewModel

    @Before
    fun before() {
        whenever(factory.makeStoryManager(any())).thenReturn(manager)
        sut = StoryViewModel(factory)
    }

    @Test
    fun `story is fetched correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")

        runBlocking {
            whenever(manager.story(any())).doAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<Story>
                observer?.invoke(Result.Success(story))
            }

            sut.story { result ->
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
            whenever(manager.story(any())).doAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<Story>
                observer?.invoke(Result.Failure(error))
            }

            sut.story { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }
}