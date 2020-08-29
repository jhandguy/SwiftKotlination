public final class URLSessionDataTaskMock: Codable {
    private(set) var isResumed: Bool

    public init() {
        isResumed = false
    }
}

extension URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    public func cancel() {
        isResumed = false
    }

    public func suspend() {
        isResumed = false
    }

    public func resume() {
        isResumed = true
    }
}
