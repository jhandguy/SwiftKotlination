import StoryKit
@testable import SwiftKotlination
import XCTest

final class CoordinatorMock {
    private(set) var isStarted = false
    private(set) var isStoryOpened = false
    private(set) var isUrlOpened = false
}

extension CoordinatorMock: CoordinatorProtocol {
    func start() {
        isStarted = true
    }

    func open(_: Story) {
        isStoryOpened = true
    }

    func open(_: String) {
        isUrlOpened = true
    }
}
