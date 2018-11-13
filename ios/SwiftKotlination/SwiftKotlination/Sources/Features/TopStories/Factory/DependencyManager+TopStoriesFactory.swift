protocol TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController
}

// MARK: - Protocol Methods

extension DependencyManager: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return TopStoriesManager(networkManager: networkManager)
    }

    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController.storyBoardInstance
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }
}
