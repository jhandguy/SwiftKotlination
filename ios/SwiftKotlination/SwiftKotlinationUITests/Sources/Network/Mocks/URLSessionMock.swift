import Foundation

final class URLSessionMock: Codable, Identifiable {
    private(set) var responses: [String: [Response]]

    init(responses: [Request: [Response]] = [:]) {
        self.responses = Dictionary( uniqueKeysWithValues:
            responses.map { request, responses in
                return (key: request.absoluteUrl, value: responses.reversed())
            }
        )
    }
}

extension URLSessionMock: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
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
