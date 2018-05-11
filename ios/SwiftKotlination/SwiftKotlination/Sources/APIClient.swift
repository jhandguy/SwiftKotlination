import Alamofire
import RxAlamofire
import RxSwift

protocol APIClientProtocol {
    func data(_ method: Alamofire.HTTPMethod, _ path: String) -> Observable<Data>
}

struct APIClient: APIClientProtocol {
    private let url = "https://api.nytimes.com/svc/"
    private let api = (key: "api-key", value: "de87f25eb97b4f038d8360e0de22e1dd")
    
    func data(_ method: Alamofire.HTTPMethod, _ path: String) -> Observable<Data> {
        return RxAlamofire
            .data(method, "\(url)\(path)", parameters: [api.key: api.value])
    }
}
