public protocol TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController
}
