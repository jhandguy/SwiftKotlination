package fr.jhandguy.swiftkotlination.features.story.viewmodel

import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import io.reactivex.Observable
import io.reactivex.rxkotlin.subscribeBy
import org.junit.After
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

        whenever(repository.story)
                .thenReturn(Observable.just(story))

        viewModel
                .story
                .subscribeBy(
                        onNext = {
                            assertEquals(it, story)
                        },
                        onError = {
                            fail(it.message)
                        }
                )
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("error message")

        whenever(repository.story)
                .thenReturn(Observable.error(error))

        viewModel
                .story
                .subscribeBy(
                        onNext = {
                            fail("Observable should throw error")
                        },
                        onError = {
                            assertEquals(it, error)
                        }
                )
    }

    @After
    fun after() {
        closeKoin()
    }

}