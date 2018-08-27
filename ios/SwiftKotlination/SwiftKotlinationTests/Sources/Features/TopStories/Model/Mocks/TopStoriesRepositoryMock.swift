import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    private var observer: Observer<[Story]>
    internal var result: Result<[Story]>
    
    init(result: Result<[Story]>, observer: @escaping Observer<[Story]> = { _ in }) {
        self.result = result
        self.observer = observer
    }
    
    func stories(_ observer: @escaping Observer<[Story]>) {
        self.observer = observer
        observer(result)
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
