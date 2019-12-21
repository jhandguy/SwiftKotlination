import NetworkKit
import UIKit.UIImage

public protocol ImageManagerProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable
}

public struct ImageManager {
    let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension ImageManager: ImageManagerProtocol {
    @discardableResult
    public func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        networkManager
            .observe(.fetchImage(url)) { result in
                switch result {
                case let .success(data):
                    guard let image = UIImage(data: data) else {
                        observer(.failure(NetworkError.invalidData))
                        return
                    }

                    observer(.success(image))

                case let .failure(error):
                    observer(.failure(error))
                }
            }
    }
}
