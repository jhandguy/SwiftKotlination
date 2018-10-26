package fr.jhandguy.swiftkotlination.features.topstories.model

import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.Result
import fr.jhandguy.swiftkotlination.features.story.model.Story
import junit.framework.Assert.assertEquals
import junit.framework.Assert.fail
import kotlinx.coroutines.experimental.async
import kotlinx.coroutines.experimental.runBlocking
import okhttp3.ResponseBody
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.dsl.module.module
import org.koin.standalone.StandAloneContext.startKoin
import org.koin.standalone.StandAloneContext.stopKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner
import retrofit2.Response

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

        whenever(service.topStories(any()))
                .thenReturn(async {
                    Response.success(topStories)
                })

        runBlocking {
            repository.topStories { result ->
                when(result) {
                    is Result.Success -> assertEquals(result.data, topStories)
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("Error fetching top stories: 404 - Response.error()")

        whenever(service.topStories(any()))
                .thenReturn(async {
                    Response.error<TopStories>(404, ResponseBody.create(null, ""))
                })

        runBlocking {
            repository.topStories { result ->
                when(result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error.message, error.message)
                }
            }
        }
    }

    @After
    fun after() {
        stopKoin()
    }
}