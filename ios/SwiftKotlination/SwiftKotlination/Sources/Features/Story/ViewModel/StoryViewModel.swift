import UIKit.UIImage

final class StoryViewModel {

    // MARK: - Private Properties

    typealias Factory = ImageFactory & StoryFactory
    private let factory: Factory
    private let story: Story

    private lazy var storyManager: StoryManagerProtocol = factory.makeStoryBoundFactory(for: story).makeStoryManager()
    private lazy var imageManager: ImageManagerProtocol = factory.makeImageManager()

    // MARK: - Initializer

    init(factory: Factory, story: Story) {
        self.factory = factory
        self.story = story
    }

    // MARK: - Internal Properties

    var image: UIImage?

    // MARK: - Internal Methods

    func story(_ observer: @escaping Observer<Story>) {
        storyManager.story(observer)
    }

    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        guard let image = image else {
            return imageManager
                .image(with: url) { [weak self] result in
                    switch result {
                    case .success(let image):
                        self?.image = image

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
