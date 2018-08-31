import XCTest
@testable import SwiftKotlination

struct StoryRepositoryMock: StoryRepositoryProtocol {
    let result: Result<Story>
    
    func story(_ observer: @escaping Observer<Story>) {
        observer(result)
    }
}
