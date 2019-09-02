package fr.jhandguy.swiftkotlination.model

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

interface ImageManagerInterface {
    suspend fun image(url: String, observer: Observer<Bitmap>): Disposable
}

class ImageManager(private val networkManager: NetworkManagerInterface) : ImageManagerInterface {
    override suspend fun image(url: String, observer: Observer<Bitmap>): Disposable =
            networkManager.observe(Request.FetchImage(url)) { result ->
                when (result) {
                    is Result.Success -> observer(Result.Success(BitmapFactory.decodeByteArray(result.data, 0, result.data.size)))
                    is Result.Failure -> observer(result)
                }
            }
}
