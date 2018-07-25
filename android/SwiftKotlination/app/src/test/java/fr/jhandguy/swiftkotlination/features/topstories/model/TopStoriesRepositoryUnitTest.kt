package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.junit.After
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.koin.test.declare

class TopStoriesRepositoryUnitTest: KoinTest {

    val repository: TopStoriesRepository by inject()

    @Before
    fun before(){
        startKoin(listOf(
                module {
                    factory { TopStoriesRepositoryImpl(get()) as TopStoriesRepository }
                }
        ))
    }

    @Test
    fun `top stories are fetched correctly`() {

        val topStories = TopStories(listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        ))

        declare {
            single { TopStoriesServiceMock(topStories) as TopStoriesService }
        }

        repository
                .topStories
                .subscribe {
                    Assert.assertEquals(it, topStories.results)
                }
    }

    @Test
    fun `error is thrown correctly`() {

        val error = Error("error message")

        declare {
            factory { TopStoriesServiceMock(error = error) as TopStoriesService }
        }

        repository
                .topStories
                .doOnError {
                    Assert.assertEquals(it, error)
                }
    }

    @After
    fun after(){
        closeKoin()
    }
}