@testable import SwiftKotlination

struct ViewControllerFactoryMock {}

extension ViewControllerFactoryMock: ViewControllerFactory {
    func makeTopStoriesTableViewController(with coordinator: CoordinatorProtocol) -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController.storyBoardInstance
        viewController.coordinator = coordinator
        viewController.viewModel = TopStoriesViewModel(factory: RepositoryFactoryMock())

        return viewController
    }

    func makeStoryViewController(with coordinator: CoordinatorProtocol, for story: Story) -> StoryViewController {
        let viewController = StoryViewController.storyBoardInstance
        viewController.coordinator = coordinator
        viewController.viewModel = StoryViewModel(story: story, factory: RepositoryFactoryMock())

        return viewController
    }
}
