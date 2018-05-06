import RxAlamofire
import RxSwift
import ObjectMapper

protocol TopStoriesRepositoryProtocol {
    var stories: Observable<[Story]> { get }
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    
    var stories: Observable<[Story]> {
        return
            requestJSON(.get, "https://api.nytimes.com/svc/topstories/v2/world.json?api-key=de87f25eb97b4f038d8360e0de22e1dd")
                .flatMap { response -> Observable<[Story]> in
                    guard
                        let (_, json) = response as? (HTTPURLResponse, [String: Any]),
                        let array = Mapper<Story>().mapArray(JSONObject: json["results"]) else {
                        return Observable.just([])
                    }
                    
                    return Observable.just(array)
                }
    }
}
