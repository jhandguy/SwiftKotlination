import Foundation

final class URLSessionMock: Codable, Identifiable {
    private var responses: [Response]
    
    private struct Response: Codable {
        var json: String?
        var error: URLSessionError?
        var dataTask: URLSessionDataTaskMock
    }
    
    init(responses: [(json: String?, error: URLSessionError?, dataTask: URLSessionDataTaskMock)] = []) {
        self.responses = responses.map { Response(json: $0.json, error: $0.error, dataTask: $0.dataTask) }
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
