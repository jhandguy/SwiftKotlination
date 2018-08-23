import Foundation

protocol APIClientProtocol {
    func subscribe(to request: Request, _ closure: @escaping Observable<Data>)
    func execute(request: Request)
}

final class APIClient {
    private var session: URLSessionProtocol
    private(set) var observables: [Request: [Observable<Data>]]
    
    init(session: URLSessionProtocol = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
        observables = [:]
    }
    
    private func execute(_ request: Request, with closures: [Observable<Data>]) {
        guard
            !closures.isEmpty,
            let urlRequest = build(request) else {
                return
        }
        
        let dataTask = session.dataTask(with: urlRequest) { data, urlResponse, error in
            guard let data = data else {
                guard let error = error else {
                    closures.forEach { $0(.failure(NetworkError.invalidResponse)) }
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
    func subscribe(to request: Request, _ closure: @escaping Observable<Data>) {
        var closures = observables[request] ?? []
        closures.append(closure)
        observables[request] = closures
        
        execute(request, with: [closure])
    }
    
    func execute(request: Request) {
        guard let closures = observables[request] else {
            return
        }
        execute(request, with: closures)
    }
}
