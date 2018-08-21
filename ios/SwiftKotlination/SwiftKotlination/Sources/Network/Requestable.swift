import Foundation

protocol Requestable {
    func build(_ request: Request) -> URLRequest?
}

extension Requestable {
    func build(_ request: Request) -> URLRequest? {
        guard let url = URL(string: request.url) else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
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
