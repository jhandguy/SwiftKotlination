import ImageKit
import NetworkKit
import UIKit.UIImage

public final class StoryViewModel {
    public typealias Factory = ImageFactory & StoryFactory
    private let factory: Factory
    private let story: Story

    private lazy var storyManager = factory.makeStoryManager(for: story)
    private lazy var imageManager = factory.makeImageManager()

    private var image: UIImage?

    public init(factory: Factory, story: Story) {
        self.factory = factory
        self.story = story
    }
}

extension StoryViewModel {
    func story(_ observer: @escaping Observer<Story>) {
        storyManager.story(observer)
    }

    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        guard let image = image else {
            return imageManager
                .image(with: url) { [weak self] result in
                    switch result {
                    case let .success(data):
                        guard let image = UIImage(data: data) else {
                            observer(.failure(NetworkError.invalidData))
                            return
                        }
                        self?.image = image
                        observer(.success(image))

                    case let .failure(error):
                        observer(.failure(error))
                    }
                }
        }

        observer(.success(image))
        return nil
    }
}
