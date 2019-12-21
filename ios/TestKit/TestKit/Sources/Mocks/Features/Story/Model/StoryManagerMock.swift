import NetworkKit
import StoryKit
import XCTest

public struct StoryManagerMock {
    public var result: Result<Story, Error>

    public init(result: Result<Story, Error> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension StoryManagerMock: StoryManagerProtocol {
    public func story(_ observer: @escaping Observer<Story>) {
        observer(result)
    }
}
