import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    private var closure: Observable<[Story]>
    internal var result: Result<[Story]>
    
    init(result: Result<[Story]>) {
        self.result = result
        self.closure = { _ in }
    }
    
    func stories(_ closure: @escaping Observable<[Story]>) {
        self.closure = closure
        closure(result)
    }
    
    func fetchStories() {
        stories(closure)
    }
}
