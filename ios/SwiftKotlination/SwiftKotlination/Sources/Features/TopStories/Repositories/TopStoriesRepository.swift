import RxAlamofire
import RxSwift
import ObjectMapper

protocol TopStoriesRepositoryProtocol {
    var stories: Observable<[Story]> { get }
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    
    private let url = "https://api.nytimes.com/svc/topstories/v2/world.json"
    private let api = (key: "api-key", value: "de87f25eb97b4f038d8360e0de22e1dd")
    
    var stories: Observable<[Story]> {
        return
            json(.get, url, parameters: [api.key: api.value])
                .flatMap { json -> Observable<[Story]> in
                    guard
                        let object = json as? [String: Any],
                        let array = Mapper<Story>().mapArray(JSONObject: object["results"]) else {
                            
                            return Observable.just([])
                    }
                    
                    return Observable.just(array)
                }
    }
}
