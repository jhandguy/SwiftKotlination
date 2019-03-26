import Foundation
@testable import SwiftKotlination

final class NetworkManagerMock: NetworkManagerProtocol {
    var result: Result<Data, Error>
    var observers: [Observer<Data>] = []

    init(result: Result<Data, Error>) {
        self.result = result
    }

    @discardableResult
    func observe(_ request: Request, _ observer: @escaping Observer<Data>) -> Disposable {
        observers.append(observer)
        execute(request)

        return Disposable {}
    }

    func execute(_ request: Request) {
        observers.forEach { $0(result) }
    }
}
