package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable
import org.junit.After
import org.junit.Assert.assertEquals
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
        val stories = listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        )

        whenever(repository.topStories).thenReturn(Observable.just(stories))

        viewModel
                .topStories
                .subscribe {
                    assertEquals(it, stories)
                }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("error message")

        whenever(repository.topStories).thenReturn(Observable.error(error))

        viewModel
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