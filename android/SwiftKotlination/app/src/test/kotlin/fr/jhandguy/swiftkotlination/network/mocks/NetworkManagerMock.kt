package fr.jhandguy.swiftkotlination.network.mocks

import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface
import fr.jhandguy.swiftkotlination.network.Request
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class NetworkManagerMock(
    val result: Result<ByteArray>,
    var observers: MutableList<Observer<ByteArray>> = ArrayList()
) : NetworkManagerInterface {

    override suspend fun observe(request: Request, observer: Observer<ByteArray>): Disposable {
        observers.add(observer)
        execute(request)

        return Disposable {}
    }

    override suspend fun execute(request: Request) = observers.forEach { it(result) }
}
