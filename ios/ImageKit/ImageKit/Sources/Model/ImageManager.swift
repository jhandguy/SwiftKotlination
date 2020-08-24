import NetworkKit

public protocol ImageManagerProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<Data>) -> Disposable
}

public struct ImageManager {
    let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension ImageManager: ImageManagerProtocol {
    @discardableResult
    public func image(with url: String, _ observer: @escaping Observer<Data>) -> Disposable {
        networkManager.observe(.fetchImage(url), observer)
    }
}
