import Alamofire
import RxSwift

struct APIClientMock: APIClientProtocol, Codable {
    static let key = "APIClientMock"
    var responses: [Request: Data]
    
    func data(_ method: Alamofire.HTTPMethod, _ path: String) -> Observable<Data> {
        
        guard let response = responses[Request(method, path)] else {
            return Observable.error(RxError.noElements)
        }
        
        return Observable.just(response)
    }
}
