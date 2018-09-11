protocol ViewControllerFactory {
    func makeTopStoriesTableViewController(with coordinator: CoordinatorProtocol) -> TopStoriesTableViewController
    func makeStoryViewController(with coordinator: CoordinatorProtocol, for story: Story) -> StoryViewController
}

extension Factory: ViewControllerFactory {

    // MARK: - Internal Methods

    func makeTopStoriesTableViewController(with coordinator: CoordinatorProtocol) -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController.storyBoardInstance
        viewController.coordinator = coordinator
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }

    func makeStoryViewController(with coordinator: CoordinatorProtocol, for story: Story) -> StoryViewController {
        let viewController = StoryViewController.storyBoardInstance
        viewController.coordinator = coordinator
        viewController.viewModel = StoryViewModel(story: story, factory: self)

        return viewController
    }
}
