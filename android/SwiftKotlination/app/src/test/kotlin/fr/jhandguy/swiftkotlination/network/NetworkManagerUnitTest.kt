package fr.jhandguy.swiftkotlination.network

import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.network.Request.FetchTopStories
import fr.jhandguy.swiftkotlination.network.mocks.URLStreamHandlerMock
import fr.jhandguy.swiftkotlination.observer.DisposeBag
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.json.Json
import kotlinx.serialization.json.JsonConfiguration
import java.util.Stack
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

class NetworkManagerUnitTest {

    lateinit var sut: NetworkManager

    @Test
    fun `request is observed correctly`() {
        val responses = Stack<Response>().apply {
            add(Response(File("top_stories", File.Extension.JSON)))
        }
        val handler = URLStreamHandlerMock(responses)

        sut = NetworkManager(handler)

        runBlocking {
            val disposeBag = DisposeBag()
            var times = 0

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val topStories = Json(JsonConfiguration(strictMode = false)).parse(TopStories.serializer(), String(result.data))
                        assertEquals(topStories.results.count(), 2)
                    }
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }.disposedBy(disposeBag)

            assertEquals(times, 1)
            assert(handler.responses.isEmpty())
            responses.forEach { response ->
                response.urlConnection.isConnected
            }

            disposeBag.dispose()

            sut.observables[Request.FetchTopStories]?.let {
                assert(it.isEmpty())
            } ?: fail("Expected observables to not be null")
        }
    }

    @Test
    fun `request is executed correctly`() {
        val responses = Stack<Response>().apply {
            addAll(
                    arrayOf(
                            Response(File("top_stories", File.Extension.JSON)),
                            Response(File("top_stories", File.Extension.JSON))
                    )
            )
        }
        val handler = URLStreamHandlerMock(responses)

        sut = NetworkManager(handler)

        runBlocking {
            val disposeBag = DisposeBag()
            var times = 0

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val topStories = Json(JsonConfiguration(strictMode = false)).parse(TopStories.serializer(), String(result.data))
                        assertEquals(topStories.results.count(), 2)
                    }
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.execute(Request.FetchTopStories)

            assertEquals(times, 2)
            assert(handler.responses.isEmpty())
            responses.forEach { response ->
                response.urlConnection.isConnected
            }

            disposeBag.dispose()

            sut.observables[Request.FetchTopStories]?.let {
                assert(it.isEmpty())
            } ?: fail("Expected observables to not be null")
        }
    }

    @Test
    fun `request is observed several times and executed correctly`() {
        val responses = Stack<Response>().apply {
            addAll(
                    arrayOf(
                            Response(File("top_stories", File.Extension.JSON)),
                            Response(error = NetworkError.InvalidResponse()),
                            Response(File("top_stories", File.Extension.JSON))
                    )
            )
        }
        val handler = URLStreamHandlerMock(responses)

        sut = NetworkManager(handler)

        runBlocking {
            val disposeBag = DisposeBag()
            var times = 0

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val topStories = Json(JsonConfiguration(strictMode = false)).parse(TopStories.serializer(), String(result.data))
                        assertEquals(topStories.results.count(), 2)
                    }
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val topStories = Json(JsonConfiguration(strictMode = false)).parse(TopStories.serializer(), String(result.data))
                        assertEquals(topStories.results.count(), 2)
                    }
                    is Result.Failure -> assertEquals(result.error.message, NetworkError.InvalidResponse().message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.execute(Request.FetchTopStories)

            assertEquals(times, 4)
            assert(handler.responses.isEmpty())
            responses.forEach { response ->
                response.urlConnection.isConnected
            }

            disposeBag.dispose()

            sut.observables[Request.FetchTopStories]?.let {
                assert(it.isEmpty())
            } ?: fail("Expected observables to not be null")
        }
    }
}