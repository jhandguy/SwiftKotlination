import Foundation

struct StoryViewModel {
    let storyRepository: StoryRepositoryProtocol
    let imageRepository: ImageRepositoryProtocol
}

extension StoryViewModel {
    func story(_ observer: @escaping Observer<Story>) {
        return storyRepository.story(observer)
    }
    
    func image(with url: String, _ observer: @escaping Observer<Data>) {
        return imageRepository.image(with: url, observer)
    }
}
