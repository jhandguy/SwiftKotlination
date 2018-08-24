import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    private var closure: Observable<[Story]>
    internal var result: Result<[Story]>
    
    init(result: Result<[Story]>, closure: @escaping Observable<[Story]> = { _ in }) {
        self.result = result
        self.closure = closure
    }
    
    func stories(_ closure: @escaping Observable<[Story]>) {
        self.closure = closure
        closure(result)
    }
    
    func fetchStories() {
        stories(closure)
    }
}
