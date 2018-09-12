@testable import SwiftKotlination

struct TopStoriesFactoryMock {
    let topStoriesManager: TopStoriesManagerMock
    let imageManager: ImageManagerMock

    init(topStoriesManager: TopStoriesManagerMock = TopStoriesManagerMock(), imageManager: ImageManagerMock = ImageManagerMock()) {
        self.topStoriesManager = topStoriesManager
        self.imageManager = imageManager
    }
}

extension TopStoriesFactoryMock: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return topStoriesManager
    }
}

extension TopStoriesFactoryMock: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
