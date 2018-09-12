@testable import SwiftKotlination

struct StoryBoundFactoryMock {
    let storyManager: StoryManagerMock

    init(storyManager: StoryManagerMock = StoryManagerMock()) {
        self.storyManager = storyManager
    }
}

extension StoryBoundFactoryMock: StoryBoundFactoryProtocol {
    func makeStoryManager() -> StoryManagerProtocol {
        return storyManager
    }
}
