protocol TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol
}

// MARK: - Protocol Methods

extension DependencyManager: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return TopStoriesManager(networkManager: networkManager)
    }
}
