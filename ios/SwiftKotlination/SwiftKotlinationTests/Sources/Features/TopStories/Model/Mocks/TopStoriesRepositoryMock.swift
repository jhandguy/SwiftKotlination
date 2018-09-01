import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    var result: Result<[Story]>
    var observer: Observer<[Story]>

    init(result: Result<[Story]>, observer: @escaping Observer<[Story]> = { _ in }) {
        self.result = result
        self.observer = observer
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

    var stories: [Story] {
        switch result {
        case .success(let stories):
            return stories
        case .failure:
            return []
        }
    }
}
