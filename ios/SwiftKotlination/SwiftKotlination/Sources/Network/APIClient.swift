import Foundation

protocol APIClientProtocol {
    func subscribe(to request: Request, _ closure: @escaping (Result<Data>) -> Void)
    func execute(request: Request)
}

final class APIClient: APIClientProtocol, Requestable {
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    private var observers: [Request: [(Result<Data>) -> Void]] = [:]
    
    private func execute(_ request: Request, with closures: [(Result<Data>) -> Void]) {
        guard
            !closures.isEmpty,
            let urlRequest = build(request) else {
            return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                closures.forEach { $0(.failure(.unknown)) }
                return
            }
            
            closures.forEach { $0(.success(data)) }
        }
        
        dataTask.resume()
    }
    
    func subscribe(to request: Request, _ closure: @escaping (Result<Data>) -> Void) {
        var closures = observers[request] ?? []
        closures.append(closure)
        observers[request] = closures
        
        execute(request, with: [closure])
    }
    
    func execute(request: Request) {
        guard let closures = observers[request] else {
            return
        }
        execute(request, with: closures)
    }
}
