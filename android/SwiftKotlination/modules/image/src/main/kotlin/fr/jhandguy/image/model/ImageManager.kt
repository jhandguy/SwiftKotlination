package fr.jhandguy.image.model

import fr.jhandguy.network.model.network.NetworkManagerInterface
import fr.jhandguy.network.model.network.Request
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer

interface ImageManagerInterface {
    suspend fun image(url: String, observer: Observer<ByteArray>): Disposable
}

class ImageManager(private val networkManager: NetworkManagerInterface) : ImageManagerInterface {
    override suspend fun image(url: String, observer: Observer<ByteArray>): Disposable =
        networkManager.observe(Request.FetchImage(url), observer)
}
