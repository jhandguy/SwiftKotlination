import XCTest
@testable import SwiftKotlination

struct ImageManagerMock {
    var result: Result<UIImage, Error>

    init(result: Result<UIImage, Error> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension ImageManagerMock: ImageManagerProtocol {
    func image(with url: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        observer(result)
        return Disposable {}
    }
}
