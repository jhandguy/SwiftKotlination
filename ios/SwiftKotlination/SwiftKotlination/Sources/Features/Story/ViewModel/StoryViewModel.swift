import UIKit

final class StoryViewModel {
    private let storyRepository: StoryRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol
    
    init(storyRepository: StoryRepositoryProtocol, imageRepository: ImageRepositoryProtocol) {
        self.storyRepository = storyRepository
        self.imageRepository = imageRepository
    }
    
    func story(_ observer: @escaping Observer<Story>) {
        storyRepository.story(observer)
    }
    
    @discardableResult
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable? {
        return imageRepository.image(with: url, observer)
    }
}
