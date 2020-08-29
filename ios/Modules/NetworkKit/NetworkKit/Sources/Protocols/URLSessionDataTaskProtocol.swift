import Foundation

public protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
    func suspend()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
