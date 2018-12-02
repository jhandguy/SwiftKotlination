package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import kotlin.test.BeforeTest
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

class StoryManagerUnitTest {

    val story = Story("section", "subsection", "title", "abstract", "url", "byline")

    lateinit var sut: StoryManager

    @BeforeTest
    fun before() {
        sut = StoryManager(story)
    }

    @Test
    fun `story is injected correctly`() {
        runBlocking {
            sut
                    .story { result ->
                        when(result) {
                            is Result.Success -> assertEquals(result.data, story)
                            is Result.Failure -> fail(result.error.message)
                        }
                    }
        }
    }
}