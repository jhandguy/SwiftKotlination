import Foundation

final class URLSessionMock: Codable, Identifiable {
    private var responses: [Response]
    
    init(results: [Result] = []) {
        responses = results.map { result in
            switch result {
            case .success(let json):
                return Response(json: json, error: nil, dataTask: URLSessionDataTaskMock())
                
            case .failure(let error):
                return Response(json: nil, error: error, dataTask: URLSessionDataTaskMock())
            }
        }
    }
    
    var dataTasks: [URLSessionDataTaskMock] {
        get {
            return responses.map { $0.dataTask }
        }
    }
}

extension URLSessionMock: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        guard
            !responses.isEmpty,
            let response = responses.popLast() else {
                return URLSessionDataTaskMock()
        }
        
        completionHandler(response.json?.data(using: .utf8), nil, response.error)
        
        return response.dataTask
    }
}

extension URLSessionMock {
    private struct Response: Codable {
        var json: String?
        var error: URLSessionError?
        var dataTask: URLSessionDataTaskMock
    }
    
    enum Result {
        case success(String?)
        case failure(URLSessionError?)
    }
}
