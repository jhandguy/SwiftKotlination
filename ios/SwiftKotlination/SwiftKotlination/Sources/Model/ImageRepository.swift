import UIKit

protocol ImageRepositoryProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable
}

struct ImageRepository {
    let apiClient: APIClientProtocol
}

// MARK: - Protocol Methods

extension ImageRepository: ImageRepositoryProtocol {
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        return apiClient
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
