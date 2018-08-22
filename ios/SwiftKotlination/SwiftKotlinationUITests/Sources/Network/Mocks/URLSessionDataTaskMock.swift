final class URLSessionDataTaskMock: Codable {
    private(set) var isResumed = false
}

extension URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {
        isResumed = true
    }
}
