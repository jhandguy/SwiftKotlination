@testable import SwiftKotlination

struct StoryFactoryMock {
    let storyBoundFactory: StoryBoundFactoryMock
    let imageManager: ImageManagerMock

    init(storyBoundFactory: StoryBoundFactoryMock = StoryBoundFactoryMock(), imageManager: ImageManagerMock = ImageManagerMock()) {
        self.storyBoundFactory = storyBoundFactory
        self.imageManager = imageManager
    }
}

extension StoryFactoryMock: StoryFactory {
    func makeStoryBoundFactory(for story: Story) -> StoryBoundFactoryProtocol {
        return storyBoundFactory
    }
}

extension StoryFactoryMock: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
