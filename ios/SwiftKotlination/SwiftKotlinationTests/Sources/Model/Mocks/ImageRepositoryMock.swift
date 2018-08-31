import XCTest
@testable import SwiftKotlination

struct ImageRepositoryMock: ImageRepositoryProtocol {
    var result: Result<UIImage>
    
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        observer(result)
        return Disposable {}
    }
}
