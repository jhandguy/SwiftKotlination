import UIKit.UIImage

final class TopStoriesViewModel {

    // MARK: - Private Properties

    typealias Factory = ImageFactory & TopStoriesFactory
    private let factory: Factory

    private lazy var topStoriesManager: TopStoriesManagerProtocol = factory.makeTopStoriesManager()
    private lazy var imageManager: ImageManagerProtocol = factory.makeImageManager()

    // MARK: - Initializer

    init(factory: Factory) {
        self.factory = factory
    }

    // MARK: - Internal Properties

    var stories: [Story] = []
    var images: [String: UIImage] = [:]

    // MARK: - Internal Methods

    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        return topStoriesManager
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
        topStoriesManager.fetchStories()
    }

    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        guard let image = images[url] else {
            return imageManager
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
