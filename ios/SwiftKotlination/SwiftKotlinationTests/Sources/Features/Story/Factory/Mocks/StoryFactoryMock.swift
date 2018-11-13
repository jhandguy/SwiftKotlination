@testable import SwiftKotlination

struct StoryFactoryMock {
    let storyManager: StoryManagerProtocol
    let imageManager: ImageManagerMock

    init(storyManager: StoryManagerProtocol = StoryManagerMock(), imageManager: ImageManagerMock = ImageManagerMock()) {
        self.storyManager = storyManager
        self.imageManager = imageManager
    }
}

extension StoryFactoryMock: StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol {
        return storyManager
    }

    func makeStoryViewController(for story: Story) -> StoryViewController {
        let viewController = StoryViewController.storyBoardInstance
        viewController.viewModel = StoryViewModel(factory: self, story: story)

        return viewController
    }
}

extension StoryFactoryMock: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
