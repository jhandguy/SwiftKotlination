package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.observer.Result
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail
import kotlinx.coroutines.runBlocking

class StoryManagerUnitTest {

    lateinit var sut: StoryManager

    @Test
    fun `story is injected correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")
        sut = StoryManager(story)

        runBlocking {
            sut
                    .story { result ->
                        when (result) {
                            is Result.Success -> assertEquals(result.data, story)
                            is Result.Failure -> fail(result.error.message)
                        }
                    }
        }
    }
}
