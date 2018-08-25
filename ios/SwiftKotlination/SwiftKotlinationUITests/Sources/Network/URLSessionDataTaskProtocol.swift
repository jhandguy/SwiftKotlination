import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
    func suspend()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
