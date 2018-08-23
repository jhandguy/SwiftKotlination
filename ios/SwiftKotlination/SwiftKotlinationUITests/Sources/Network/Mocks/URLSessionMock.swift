import Foundation

final class URLSessionMock: Codable, Identifiable {
    private var responses: [Response]
    
    private struct Response: Codable {
        var json: String?
        var error: NetworkError?
        var dataTask: URLSessionDataTaskMock
    }
    
    init(results: [(json: String?, error: NetworkError?)] = []) {
        responses = results.map { result in
            Response(json: result.json, error: result.error, dataTask: URLSessionDataTaskMock())
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
