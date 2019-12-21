import NetworkKit
import StoryKit
import TopStoriesKit

public final class TopStoriesManagerMock {
    public var result: Result<[Story], Error>
    private(set) var observer: Observer<[Story]>

    public init(result: Result<[Story], Error> = .failure(NetworkError.invalidResponse)) {
        self.result = result
        observer = { _ in }
    }
}

extension TopStoriesManagerMock: TopStoriesManagerProtocol {
    @discardableResult
    public func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        self.observer = observer
        observer(result)

        return Disposable {}
    }

    public func fetchStories() {
        stories(observer)
    }
}
