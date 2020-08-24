package fr.jhandguy.network.model.network

import fr.jhandguy.network.model.network.Request.FetchTopStories
import fr.jhandguy.network.model.network.mocks.URLStreamHandlerMock
import fr.jhandguy.network.model.observer.DisposeBag
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.test.network.File
import fr.jhandguy.test.network.Response
import kotlinx.coroutines.runBlocking
import java.util.Stack
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

class NetworkManagerUnitTest {

    lateinit var sut: NetworkManager

    @Test
    fun `request is observed correctly`() {
        val file = File("top_stories", File.Extension.JSON)
        val responses = Stack<Response>().apply {
            add(Response(file))
        }
        val handler = URLStreamHandlerMock(responses)

        sut = NetworkManager(handler)

        runBlocking {
            val disposeBag = DisposeBag()
            var times = 0

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val data = file.data?.readBytes()?.let {
                            String(it)
                        }
                        assertEquals(data, String(result.data))
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
        val file = File("top_stories", File.Extension.JSON)
        val responses = Stack<Response>().apply {
            addAll(
                arrayOf(
                    Response(file),
                    Response(file)
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
                        val data = file.data?.readBytes()?.let {
                            String(it)
                        }
                        assertEquals(data, String(result.data))
                    }
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.execute(FetchTopStories)

            assertEquals(times, 2)
            assert(handler.responses.isEmpty())
            responses.forEach { response ->
                response.urlConnection.isConnected
            }

            disposeBag.dispose()

            sut.observables[FetchTopStories]?.let {
                assert(it.isEmpty())
            } ?: fail("Expected observables to not be null")
        }
    }

    @Test
    fun `request is observed several times and executed correctly`() {
        val file = File("top_stories", File.Extension.JSON)
        val responses = Stack<Response>().apply {
            addAll(
                arrayOf(
                    Response(file),
                    Response(error = NetworkError.InvalidResponse()),
                    Response(file)
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
                        val data = file.data?.readBytes()?.let {
                            String(it)
                        }
                        assertEquals(data, String(result.data))
                    }
                    is Result.Failure -> fail(result.error.message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.observe(FetchTopStories) { result ->
                when (result) {
                    is Result.Success -> {
                        val data = file.data?.readBytes()?.let {
                            String(it)
                        }
                        assertEquals(data, String(result.data))
                    }
                    is Result.Failure -> assertEquals(result.error.message, NetworkError.InvalidResponse().message)
                }
                times += 1
            }.disposedBy(disposeBag)

            sut.execute(FetchTopStories)

            assertEquals(times, 4)
            assert(handler.responses.isEmpty())
            responses.forEach { response ->
                response.urlConnection.isConnected
            }

            disposeBag.dispose()

            sut.observables[FetchTopStories]?.let {
                assert(it.isEmpty())
            } ?: fail("Expected observables to not be null")
        }
    }
}
