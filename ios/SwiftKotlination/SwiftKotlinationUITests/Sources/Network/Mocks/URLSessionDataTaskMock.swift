final class URLSessionDataTaskMock: Codable {
    private(set) var isResumed = false
}

extension URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    func cancel() {
        isResumed = false
    }
    
    func suspend() {
        isResumed = false
    }
    
    func resume() {
        isResumed = true
    }
}
