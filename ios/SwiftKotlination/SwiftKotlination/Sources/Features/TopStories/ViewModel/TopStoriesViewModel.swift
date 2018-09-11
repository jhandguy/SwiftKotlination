import UIKit.UIImage

final class TopStoriesViewModel {

    // MARK: - Private Properties

    private let factory: RepositoryFactory

    private lazy var topStoriesRepository: TopStoriesRepositoryProtocol = factory.makeTopStoriesRepository()
    private lazy var imageRepository: ImageRepositoryProtocol = factory.makeImageRepository()

    // MARK: - Initializer

    init(factory: RepositoryFactory) {
        self.factory = factory
    }

    // MARK: - Internal Properties

    var stories: [Story] = []
    var images: [String: UIImage] = [:]

    // MARK: - Internal Methods

    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        return topStoriesRepository
            .stories { [weak self] result in
                switch result {
                case .success(let stories):
                    self?.stories = stories

                case .failure:
                    break
                }
                observer(result)
        }
    }

    func refresh() {
        topStoriesRepository.fetchStories()
    }

    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        guard let image = images[url] else {
            return imageRepository
                .image(with: url) { [weak self] result in
                    switch result {
                    case .success(let image):
                        self?.images[url] = image

                    case .failure:
                        break
                    }
                    observer(result)
            }
        }

        observer(.success(image))
        return nil
    }
}
