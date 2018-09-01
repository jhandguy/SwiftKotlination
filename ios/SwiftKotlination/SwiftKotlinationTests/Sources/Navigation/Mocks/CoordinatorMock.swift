import XCTest
@testable import SwiftKotlination

final class CoordinatorMock: CoordinatorProtocol {
    private(set) var isStarted = false
    private(set) var isStoryOpened = false
    private(set) var isUrlOpened = false

    func start() {
        isStarted = true
    }

    func open(_ story: Story) {
        isStoryOpened = true
    }

    func open(_ url: URL) {
        isUrlOpened = true
    }
}
