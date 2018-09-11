protocol RepositoryFactory {
    func makeTopStoriesRepository() -> TopStoriesRepositoryProtocol
    func makeStoryRepository(for story: Story) -> StoryRepositoryProtocol
    func makeImageRepository() -> ImageRepositoryProtocol
}

extension Factory: RepositoryFactory {

    // MARK: - Internal Methods

    func makeTopStoriesRepository() -> TopStoriesRepositoryProtocol {
        return TopStoriesRepository(apiClient: apiClient)
    }

    func makeStoryRepository(for story: Story) -> StoryRepositoryProtocol {
        return StoryRepository(story: story)
    }

    func makeImageRepository() -> ImageRepositoryProtocol {
        return ImageRepository(apiClient: apiClient)
    }
}
