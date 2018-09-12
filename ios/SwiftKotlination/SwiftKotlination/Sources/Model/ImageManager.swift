import UIKit.UIImage

protocol ImageManagerProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable
}

struct ImageManager {
    let networkManager: NetworkManagerProtocol
}

// MARK: - Protocol Methods

extension ImageManager: ImageManagerProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        return networkManager
            .observe(.fetchImage(url)) { result in
                switch result {
                case .success(let data):
                    guard let image = UIImage(data: data) else {
                        observer(.failure(NetworkError.invalidResponse))
                        return
                    }

                    observer(.success(image))

                case .failure(let error):
                    observer(.failure(error))
                }
        }
    }
}
