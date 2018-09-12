@testable import SwiftKotlination

struct ViewControllerFactoryMock {
    let imageManager: ImageManagerMock
    let topStoriesManager: TopStoriesManagerMock
    let storyBoundFactory: StoryBoundFactoryMock

    init(
        imageManager: ImageManagerMock = ImageManagerMock(),
        topStoriesManager: TopStoriesManagerMock = TopStoriesManagerMock(),
        storyBoundFactory: StoryBoundFactoryMock = StoryBoundFactoryMock()
        ) {

        self.imageManager = imageManager
        self.topStoriesManager = topStoriesManager
        self.storyBoundFactory = storyBoundFactory
    }
}

extension ViewControllerFactoryMock: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}

extension ViewControllerFactoryMock: StoryFactory {
    func makeStoryBoundFactory(for story: Story) -> StoryBoundFactoryProtocol {
        return storyBoundFactory
    }
}

extension ViewControllerFactoryMock: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return topStoriesManager
    }
}

extension ViewControllerFactoryMock: ViewControllerFactory {
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController.storyBoardInstance
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }

    func makeStoryViewController(for story: Story) -> StoryViewController {
        let viewController = StoryViewController.storyBoardInstance
        viewController.viewModel = StoryViewModel(factory: self, story: story)

        return viewController
    }
}
