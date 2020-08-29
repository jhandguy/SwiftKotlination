import ImageKit
import NetworkKit

public struct ImageManagerMock {
    public var result: Result<Data, Error>

    public init(result: Result<Data, Error> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension ImageManagerMock: ImageManagerProtocol {
    public func image(with _: String, _ observer: @escaping Observer<Data>) -> Disposable {
        observer(result)
        return Disposable {}
    }
}
