import Alamofire
import RxSwift
@testable import SwiftKotlination

final class APIClientMock: APIClientProtocol {
    var dataStub: DataStub
    
    init(dataStub: DataStub = .failure(.timeout)) {
        self.dataStub = dataStub
    }
    
    enum DataStub {
        case success(String)
        case failure(RxError)
    }
    
    func data(_ method: Alamofire.HTTPMethod, _ path: String) -> Observable<Data> {
        
        switch dataStub {
        case .success(let fileName):
            guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
                fatalError("Unable to read \(String(describing: fileName)).json")
            }
            
            guard let data = try? Data(contentsOf: url) else {
                fatalError("Unable to read \(url.path)")
            }
            
            return Observable.just(data)
            
        case .failure(let error):
            return Observable.error(error)
        }
        
    }
}
