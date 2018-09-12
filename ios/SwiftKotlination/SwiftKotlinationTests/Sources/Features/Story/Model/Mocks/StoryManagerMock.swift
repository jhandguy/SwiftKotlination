import XCTest
@testable import SwiftKotlination

struct StoryManagerMock {
    var result: Result<Story>

    init(result: Result<Story> = .failure(NetworkError.invalidResponse)) {
        self.result = result
    }
}

extension StoryManagerMock: StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>) {
        observer(result)
    }
}
