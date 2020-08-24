package fr.jhandguy.test.image.mocks

import fr.jhandguy.image.model.ImageManagerInterface
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result

class ImageManagerMock(val result: Result<ByteArray>) : ImageManagerInterface {
    override suspend fun image(url: String, observer: Observer<ByteArray>): Disposable {
        observer(result)

        return Disposable {}
    }
}
