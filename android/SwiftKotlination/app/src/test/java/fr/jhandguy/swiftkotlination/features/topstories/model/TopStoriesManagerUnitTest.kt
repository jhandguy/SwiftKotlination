package fr.jhandguy.swiftkotlination.features.topstories.model

import com.nhaarman.mockitokotlin2.any
import com.nhaarman.mockitokotlin2.eq
import com.nhaarman.mockitokotlin2.whenever
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result
import junit.framework.Assert.assertEquals
import junit.framework.Assert.fail
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.JSON
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

@RunWith(MockitoJUnitRunner::class)
class TopStoriesManagerUnitTest: KoinTest {

    @Mock
    lateinit var networkManager: NetworkManagerInterface

    val sut: TopStoriesManagerInterface by inject()

    @Before
    fun before() {
        startKoin(listOf(
                module {
                    factory { TopStoriesManager(networkManager) as TopStoriesManagerInterface }
                }
        ))
    }

    @Test
    fun `top stories are fetched correctly`() {
        val topStories = TopStories(listOf(
                Story("section1", "subsection1", "title1", "abstract1", "url1", "byline1"),
                Story("section2", "subsection2", "title2", "abstract2", "url2", "byline2")
        ))

        launch {
            whenever(networkManager.observe(eq(Request.FetchTopStories), any())).thenAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<String>
                observer?.invoke(Result.Success(JSON.stringify(TopStories.serializer(), topStories)))
            }
        }

        runBlocking {
            sut.topStories { result ->
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

        launch {
            whenever(networkManager.observe(eq(Request.FetchTopStories), any())).thenAnswer {
                @Suppress("UNCHECKED_CAST")
                val observer = it.arguments.first() as? Observer<String>
                observer?.invoke(Result.Failure(NetworkError.InvalidResponse()))
            }
        }

        runBlocking {
            sut.topStories { result ->
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