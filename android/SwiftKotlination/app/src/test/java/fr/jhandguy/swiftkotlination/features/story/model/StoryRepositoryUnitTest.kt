package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.Result
import kotlinx.coroutines.runBlocking
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.fail
import org.junit.Before
import org.junit.Test
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.StandAloneContext.stopKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest

class StoryRepositoryUnitTest: KoinTest {

    val story = Story("section", "subsection", "title", "abstract", "url", "byline")

    val repository: StoryRepository by inject()

    @Before
    fun before() {
        startKoin(listOf(
                module {
                    factory { StoryRepositoryImpl(story) as StoryRepository }
                }
        ))
    }

    @Test
    fun `story is injected correctly`() {
        runBlocking {
            repository
                    .story { result ->
                        when(result) {
                            is Result.Success -> assertEquals(result.data, story)
                            is Result.Failure -> fail(result.error.message)
                        }
                    }
        }
    }

    @After
    fun after() {
        stopKoin()
    }
}