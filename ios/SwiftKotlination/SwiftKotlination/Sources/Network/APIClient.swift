import Foundation

protocol APIClientProtocol {
    func subscribe(to request: Request, _ closure: @escaping (Result<Data>) -> Void)
    func execute(request: Request)
}

final class APIClient {
    private var session: URLSessionProtocol
    private(set) var observers: [Request: [(Result<Data>) -> Void]]
    
    init(session: URLSessionProtocol = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
        observers = [:]
    }
    
    private func execute(_ request: Request, with closures: [(Result<Data>) -> Void]) {
        guard
            !closures.isEmpty,
            let urlRequest = build(request) else {
                return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                guard let error = error else {
                    closures.forEach { $0(.failure(ResultError.unknown)) }
                    return
                }
                
                closures.forEach { $0(.failure(error)) }
                return
            }
            
            closures.forEach { $0(.success(data)) }
        }
        
        dataTask.resume()
    }
    
    private func build(_ request: Request) -> URLRequest? {
        guard let url = URL(string: request.url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.name
        
        switch request.parameters {
        case .body(let data):
            urlRequest.httpBody = data
            
        case .url(let dictionary):
            guard var urlComponents = URLComponents(string: request.url) else {
                return urlRequest
            }
            
            urlComponents.queryItems = dictionary.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
            urlRequest.url = urlComponents.url
        case .none:
            break
        }
        
        return urlRequest
    }
}

extension APIClient: APIClientProtocol {
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
