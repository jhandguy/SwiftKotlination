import UIKit

final class TopStoriesViewModel {

    // MARK: - Private Properties

    private let topStoriesRepository: TopStoriesRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol

    // MARK: - Initializer

    init(topStoriesRepository: TopStoriesRepositoryProtocol, imageRepository: ImageRepositoryProtocol) {
        self.topStoriesRepository = topStoriesRepository
        self.imageRepository = imageRepository
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
