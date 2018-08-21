import XCTest
@testable import SwiftKotlination

final class StoryRepositoryMock: StoryRepositoryProtocol {
    private let result: Result<Story>
    
    init(result: Result<Story>) {
        self.result = result
    }
    
    func story(_ closure: @escaping (Result<Story>) -> Void) {
        closure(result)
    }
}
