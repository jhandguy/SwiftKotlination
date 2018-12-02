package fr.jhandguy.swiftkotlination.features.story.viewmodel

import fr.jhandguy.swiftkotlination.features.story.factory.mocks.StoryFactoryMock
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.mocks.StoryManagerMock
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import kotlin.test.assertEquals
import kotlin.test.fail
import kotlin.test.Test

class StoryViewModelUnitTest {

    lateinit var sut: StoryViewModel

    @Test
    fun `story is fetched correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")
        val manager = StoryManagerMock(Result.Success(story))
        val factory = StoryFactoryMock(manager)
        sut = StoryViewModel(factory)

        runBlocking {
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
        val manager = StoryManagerMock(Result.Failure(error))
        val factory = StoryFactoryMock(manager)
        sut = StoryViewModel(factory)

        runBlocking {
            sut.story { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error, error)
                }
            }
        }
    }
}