package fr.jhandguy.swiftkotlination.model.mocks

import android.graphics.Bitmap
import fr.jhandguy.swiftkotlination.model.ImageManagerInterface
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class ImageManagerMock(val result: Result<Bitmap>) : ImageManagerInterface {
    override suspend fun image(url: String, observer: Observer<Bitmap>): Disposable {
        observer(result)

        return Disposable {}
    }
}
