import RxAlamofire
import RxSwift

protocol TopStoriesRepositoryProtocol {
    var stories: Observable<[Story]> { get }
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    
    private let url = "https://api.nytimes.com/svc/topstories/v2/home.json"
    private let api = (key: "api-key", value: "de87f25eb97b4f038d8360e0de22e1dd")
    
    var stories: Observable<[Story]> {
        return
            data(.get, url, parameters: [api.key: api.value])
                .flatMap { data -> Observable<[Story]> in
                    guard let topStories = try? JSONDecoder().decode(TopStories.self, from: data) else {
                        return Observable.just([])
                    }
                    
                    return Observable.just(topStories.results)
                }
    }
}
