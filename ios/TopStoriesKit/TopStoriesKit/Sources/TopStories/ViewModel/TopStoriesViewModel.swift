import ImageKit
import NetworkKit
import StoryKit
import UIKit.UIImage

public final class TopStoriesViewModel {
    public typealias Factory = ImageFactory & TopStoriesFactory
    private let factory: Factory

    private lazy var topStoriesManager = factory.makeTopStoriesManager()
    private lazy var imageManager = factory.makeImageManager()

    public init(factory: Factory) {
        self.factory = factory
    }

    var stories: [Story] = []
    var images: [String: UIImage] = [:]
}

extension TopStoriesViewModel {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        topStoriesManager
            .stories { [weak self] result in
                switch result {
                case let .success(stories):
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
                    case let .success(image):
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
