import XCTest
@testable import SwiftKotlination

final class TopStoriesManagerMock {
    var result: Result<[Story]>
    var observer: Observer<[Story]>

    init(result: Result<[Story]> = .failure(NetworkError.invalidResponse)) {
        self.result = result
        self.observer = { _ in }
    }
}

extension TopStoriesManagerMock: TopStoriesManagerProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        self.observer = observer
        observer(result)

        return Disposable {}
    }

    func fetchStories() {
        stories(observer)
    }
}
