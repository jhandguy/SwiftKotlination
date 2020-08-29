import ImageKit
import StoryKit

public struct StoryFactoryMock {
    public let storyManager: StoryManagerMock
    public let imageFactory: ImageFactoryMock

    public init(storyManager: StoryManagerMock = StoryManagerMock(), imageManager: ImageManagerMock = ImageManagerMock()) {
        self.storyManager = storyManager
        imageFactory = ImageFactoryMock(imageManager: imageManager)
    }
}

extension StoryFactoryMock: StoryFactory {
    public func makeStoryManager(for _: Story) -> StoryManagerProtocol {
        storyManager
    }

    public func makeStoryViewController(for story: Story) -> StoryViewController {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(factory: self, story: story)

        return viewController
    }
}

extension StoryFactoryMock: ImageFactory {
    public func makeImageManager() -> ImageManagerProtocol {
        imageFactory.makeImageManager()
    }
}
