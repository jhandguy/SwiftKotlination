import Foundation

protocol ImageRepositoryProtocol {
    func image(with url: String, _ observer: @escaping Observer<Data>)
}

final class ImageRepository: ImageRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private(set) var images: [String: Data]
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
        self.images = [:]
    }
    
    func image(with url: String, _ observer: @escaping Observer<Data>) {
        guard let image = images[url] else {
            apiClient.observe(.fetchImage(url)) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.images[url] = data
                    
                case .failure:
                    break
                }
                
                observer(result)
            }
            return
        }
        
        observer(.success(image))
    }
}
