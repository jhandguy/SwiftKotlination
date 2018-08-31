import XCTest
@testable import SwiftKotlination

final class ImageRepositoryMock: ImageRepositoryProtocol {
    var result: Result<Data>
    
    init(result: Result<Data>) {
        self.result = result
    }
    
    func image(with url: String, _ observer: @escaping (Result<Data>) -> Void) {
        observer(result)
    }
}
