import RxAlamofire
import RxSwift

protocol TopStoriesRepositoryProtocol {
    var stories: Observable<[Story]> { get }
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    var apiClient: APIClientProtocol
    
    var stories: Observable<[Story]> {
        return
            apiClient
                .data(.get, "topstories/v2/home.json")
                .flatMap { data -> Observable<[Story]> in
                    guard let topStories = try? JSONDecoder().decode(TopStories.self, from: data) else {
                        return Observable.just([])
                    }
                    
                    return Observable.just(topStories.results)
                }
    }
}
