package fr.jhandguy.test.network.mocks

import fr.jhandguy.network.model.network.NetworkManagerInterface
import fr.jhandguy.network.model.network.Request
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import kotlin.collections.ArrayList

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
