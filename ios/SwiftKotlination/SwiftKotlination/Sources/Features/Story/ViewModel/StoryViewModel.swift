import UIKit.UIImage

final class StoryViewModel {

    typealias Factory = ImageFactory & StoryFactory
    private let factory: Factory
    private let story: Story

    private lazy var storyManager = factory.makeStoryManager(for: story)
    private lazy var imageManager = factory.makeImageManager()

    init(factory: Factory, story: Story) {
        self.factory = factory
        self.story = story
    }

    var image: UIImage?

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
