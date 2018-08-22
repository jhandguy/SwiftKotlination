import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    private var closure: (Result<[Story]>) -> Void
    internal var result: Result<[Story]>
    
    init(result: Result<[Story]>) {
        self.result = result
        self.closure = { _ in }
    }
    
    func stories(_ closure: @escaping (Result<[Story]>) -> Void) {
        self.closure = closure
        closure(result)
    }
    
    func fetchStories() {
        stories(closure)
    }
}
