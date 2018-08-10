package fr.jhandguy.swiftkotlination.features.topstories.model

import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import io.reactivex.Observable
import io.reactivex.rxkotlin.subscribeBy
import org.junit.After
import org.junit.Assert
import org.junit.Assert.assertEquals
import org.junit.Assert.fail
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner

@RunWith(MockitoJUnitRunner::class)
class TopStoriesRepositoryUnitTest: KoinTest {

    @Mock
    lateinit var service: TopStoriesService

    val repository: TopStoriesRepository by inject()

    @Before
    fun before() {
        startKoin(listOf(
                module {
                    factory { TopStoriesRepositoryImpl(service) as TopStoriesRepository }
                }
        ))
    }

    @Test
    fun `top stories are fetched correctly`() {
        val topStories = TopStories(listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        ))

        whenever(service.getObservable(any()))
                .thenReturn(Observable.just(topStories))

        repository
                .topStories
                .subscribeBy(
                        onNext = {
                            assertEquals(it, topStories.results)
                        },
                        onError = {
                            fail(it.message)
                        }
                )
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("error message")

        whenever(service.getObservable(any()))
                .thenReturn(Observable.error(error))

        repository
                .topStories
                .doOnError {
                    assertEquals(it, error)
                }
    }

    @After
    fun after() {
        closeKoin()
    }
}