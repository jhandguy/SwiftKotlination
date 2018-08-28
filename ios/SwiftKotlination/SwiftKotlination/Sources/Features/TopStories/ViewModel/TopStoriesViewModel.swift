import Foundation

struct TopStoriesViewModel {
    let topStoriesRepository: TopStoriesRepositoryProtocol
    let imageRepository: ImageRepositoryProtocol
}

extension TopStoriesViewModel {
    func stories(_ observer: @escaping Observer<[Story]>) {
        topStoriesRepository.stories(observer)
    }
    
    func refresh() {
        topStoriesRepository.fetchStories()
    }
    
    func image(with url: String, _ observer: @escaping Observer<Data>) {
        imageRepository.image(with: url, observer)
    }
    
    var stories: [Story] {
        return topStoriesRepository.stories
    }
}
