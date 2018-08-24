import Foundation
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    private var observers: [Observer<Data>] = []
    private let result: Result<String?>
    
    init(result: Result<String?>) {
        self.result = result
    }
    
    func observe(_ request: Request, _ observer: @escaping Observer<Data>) {
        observers.append(observer)
        execute(request)
    }
    
    func execute(_ request: Request) {
        switch result {
        case .success(let json):
            guard
                let json = json,
                let data = json.data(using: .utf8) else {
                    
                observers.forEach { $0(.failure(NetworkError.invalidResponse)) }
                return
            }
            
            observers.forEach { $0(.success(data)) }
        case .failure(let error):
            observers.forEach { $0(.failure(error)) }
        }
    }
}
