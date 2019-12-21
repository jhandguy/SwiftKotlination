import ImageKit
import NetworkKit
import UIKit

public struct ImageManagerMock {
    public var result: Result<UIImage, Error>

    public init(result: Result<UIImage, Error> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension ImageManagerMock: ImageManagerProtocol {
    public func image(with _: String, _ observer: @escaping Observer<UIImage>) -> Disposable {
        observer(result)
        return Disposable {}
    }
}
