protocol ViewControllerFactory {
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController
    func makeStoryViewController(for story: Story) -> StoryViewController
}

// MARK: - Protocol Methods

extension DependencyManager: ViewControllerFactory {
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
