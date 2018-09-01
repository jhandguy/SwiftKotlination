import UIKit

final class StoryViewModel {
    private let storyRepository: StoryRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol

    var image: UIImage?

    init(storyRepository: StoryRepositoryProtocol, imageRepository: ImageRepositoryProtocol) {
        self.storyRepository = storyRepository
        self.imageRepository = imageRepository
    }

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
