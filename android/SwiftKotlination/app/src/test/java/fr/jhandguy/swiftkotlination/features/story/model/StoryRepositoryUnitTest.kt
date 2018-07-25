package fr.jhandguy.swiftkotlination.features.story.model

import junit.framework.Assert.assertEquals
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.koin.test.declare

class StoryRepositoryUnitTest: KoinTest {

    val repository: StoryRepository by inject()

    @Before
    fun before(){
        startKoin(listOf(
                module {
                    factory { StoryRepositoryImpl(get()) as StoryRepository }
                }
        ))
    }

    @Test
    fun `story is injected correctly`() {
        val story = Story("section", "subsection", "title", "abstract", "url", "byline")

        declare {
            factory { story }
        }

        repository
                .story
                .subscribe {
                    assertEquals(it, story)
                }
    }

    @After
    fun after(){
        closeKoin()
    }
}