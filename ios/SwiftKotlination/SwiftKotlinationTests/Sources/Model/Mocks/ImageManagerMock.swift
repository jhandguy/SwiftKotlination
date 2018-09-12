import XCTest
@testable import SwiftKotlination

struct ImageManagerMock {
    var result: Result<UIImage>

    init(result: Result<UIImage> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension ImageManagerMock: ImageManagerProtocol {
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        observer(result)
        return Disposable {}
    }
}
