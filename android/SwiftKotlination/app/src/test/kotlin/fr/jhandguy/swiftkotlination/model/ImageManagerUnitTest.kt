package fr.jhandguy.swiftkotlination.model

import android.graphics.BitmapFactory
import fr.jhandguy.swiftkotlination.network.File
import fr.jhandguy.swiftkotlination.network.mocks.NetworkManagerMock
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.coroutines.runBlocking
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.fail

@RunWith(RobolectricTestRunner::class)
class ImageManagerUnitTest {

    lateinit var sut: ImageManager

    @Test
    fun `image is observed correctly`() {
        val stream = File("27arizpolitics7-thumbLarge", File.Extension.JPG).data
            ?: fail("Expected ClassLoader to not be null")
        val byteArray = stream.readBytes()
        val bitmap = BitmapFactory.decodeByteArray(byteArray, 0, byteArray.size)
        val networkManager = NetworkManagerMock(Result.Success(byteArray))
        sut = ImageManager(networkManager)

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> assert(result.data.sameAs(bitmap))
                    is Result.Failure -> fail(result.error.message)
                }
            }
        }
    }

    @Test
    fun `error is thrown correctly`() {
        val error = Error("Error fetching image: 404 - Response.error()")
        val networkManager = NetworkManagerMock(Result.Failure(error))
        sut = ImageManager(networkManager)

        runBlocking {
            sut.image("") { result ->
                when (result) {
                    is Result.Success -> fail("Coroutine should throw error")
                    is Result.Failure -> assertEquals(result.error.message, error.message)
                }
            }
        }
    }
}