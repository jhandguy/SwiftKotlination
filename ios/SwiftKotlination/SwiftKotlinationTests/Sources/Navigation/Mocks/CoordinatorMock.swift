import XCTest
@testable import SwiftKotlination

final class CoordinatorMock: CoordinatorProtocol {
    private(set) var didStart = false
    private(set) var didOpenStory = false
    private(set) var didOpenUrl = false
    
    func start() {
        didStart = true
    }
    
    func open(_ story: Story) {
        didOpenStory = true
    }
    
    func open(_ url: URL) {
        didOpenUrl = true
    }
}
