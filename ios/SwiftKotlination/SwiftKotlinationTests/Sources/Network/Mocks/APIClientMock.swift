import Foundation
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    var result: Result<Data>
    var observers: [Observer<Data>] = []

    init(result: Result<Data>) {
        self.result = result
    }

    @discardableResult
    func observe(_ request: Request, _ observer: @escaping Observer<Data>) -> Disposable {
        observers.append(observer)
        execute(request)

        return Disposable {}
    }

    func execute(_ request: Request) {
        switch result {
        case .success(let data):
            observers.forEach { $0(.success(data)) }
        case .failure(let error):
            observers.forEach { $0(.failure(error)) }
        }
    }
}
