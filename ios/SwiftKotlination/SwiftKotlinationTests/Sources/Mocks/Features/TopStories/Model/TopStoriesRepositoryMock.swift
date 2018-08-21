import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    private let result: Result<[Story]>
    
    init(result: Result<[Story]>) {
        self.result = result
    }
    
    func stories(_ closure: @escaping (Result<[Story]>) -> Void) {
        closure(result)
    }
    
    func fetchStories() {}
}
