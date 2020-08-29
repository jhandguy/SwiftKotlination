import Foundation
import NetworkKit

public final class NetworkManagerMock: NetworkManagerProtocol {
    public var result: Result<Data, Error>
    var observers: [Observer<Data>] = []

    public init(result: Result<Data, Error>) {
        self.result = result
    }

    @discardableResult
    public func observe(_ request: Request, _ observer: @escaping Observer<Data>) -> Disposable {
        observers.append(observer)
        execute(request)

        return Disposable {}
    }

    public func execute(_: Request) {
        observers.forEach { $0(result) }
    }
}
