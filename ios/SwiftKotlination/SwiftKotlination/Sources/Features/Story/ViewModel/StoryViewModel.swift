import UIKit.UIImage

final class StoryViewModel {

    // MARK: - Private Properties

    private let story: Story
    private let factory: RepositoryFactory

    private lazy var storyRepository: StoryRepositoryProtocol = factory.makeStoryRepository(for: story)
    private lazy var imageRepository: ImageRepositoryProtocol = factory.makeImageRepository()

    // MARK: - Initializer

    init(story: Story, factory: RepositoryFactory) {
        self.story = story
        self.factory = factory
    }

    // MARK: - Internal Properties

    var image: UIImage?

    // MARK: - Internal Methods

    func story(_ observer: @escaping Observer<Story>) {
        storyRepository.story(observer)
    }

    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        guard let image = image else {
            return imageRepository
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
