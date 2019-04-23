protocol TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController
}

extension DependencyManager: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return TopStoriesManager(networkManager: networkManager)
    }

    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController()
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }
}
