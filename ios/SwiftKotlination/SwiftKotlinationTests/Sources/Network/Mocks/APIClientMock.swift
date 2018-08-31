import Foundation
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    private var observers: [Observer<Data>] = []
    var result: Result<Data>
    
    init(result: Result<Data>) {
        self.result = result
    }
    
    func observe(_ request: Request, _ observer: @escaping Observer<Data>) {
        observers.append(observer)
        execute(request)
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
