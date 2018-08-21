import Foundation
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    private var closures: [(Result<Data>) -> Void] = []
    private let result: Result<File>
    
    init(result: Result<File>) {
        self.result = result
    }
    
    func subscribe(to request: Request, _ closure: @escaping (Result<Data>) -> Void) {
        closures.append(closure)
        execute(request: request)
    }
    
    func execute(request: Request) {
        switch result {
        case .success(let file):
            guard
                let url = Bundle(for: type(of: self))
                    .url(forResource: file.name, withExtension: file.extension.rawValue),
                let data = try? Data(contentsOf: url) else {
                    return
            }
            
            closures.forEach { $0(.success(data)) }
        case .failure(let error):
            closures.forEach { $0(.failure(error)) }
        }
    }
}
