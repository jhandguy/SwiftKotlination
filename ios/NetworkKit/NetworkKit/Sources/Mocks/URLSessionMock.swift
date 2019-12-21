import ExtensionKit
import Foundation

public final class URLSessionMock: Codable, Taggable {
    private(set) var responses: [String: [Response]]

    public init(responses: [Request: [Response]] = [:]) {
        self.responses = Dictionary(uniqueKeysWithValues:
            responses.map { request, responses in
                (key: request.absoluteUrl, value: responses.reversed())
        })
    }
}

extension URLSessionMock: URLSessionProtocol {
    public func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        guard
            let url = request.url?.absoluteString,
            let response = responses[url]?.popLast() else {
            completionHandler(nil, nil, NetworkError.invalidRequest)
            return URLSessionDataTaskMock()
        }

        completionHandler(response.file?.data, nil, response.error)

        return response.dataTask
    }
}
