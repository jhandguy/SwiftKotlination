import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    var result: Result<[Story]>
    var observer: Observer<[Story]>

    init(result: Result<[Story]>) {
        self.result = result
        self.observer = { _ in }
    }

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
