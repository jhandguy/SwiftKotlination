import Foundation

final class URLSessionMock: Codable, Identifiable {
    private(set) var responses: [Response]
    
    init(responses: [Response] = []) {
        self.responses = responses
    }
}

extension URLSessionMock: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        guard
            !responses.isEmpty,
            let response = responses.popLast() else {
                return URLSessionDataTaskMock()
        }
        
        completionHandler(response.file?.data, nil, response.error)
        
        return response.dataTask
    }
}
