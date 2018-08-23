import Foundation
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    private var closures: [Observable<Data>] = []
    private let result: Result<String?>
    
    init(result: Result<String?>) {
        self.result = result
    }
    
    func subscribe(to request: Request, _ closure: @escaping Observable<Data>) {
        closures.append(closure)
        execute(request: request)
    }
    
    func execute(request: Request) {
        switch result {
        case .success(let json):
            guard
                let json = json,
                let data = json.data(using: .utf8) else {
                    
                closures.forEach { $0(.failure(NetworkError.invalidResponse)) }
                return
            }
            
            closures.forEach { $0(.success(data)) }
        case .failure(let error):
            closures.forEach { $0(.failure(error)) }
        }
    }
}
