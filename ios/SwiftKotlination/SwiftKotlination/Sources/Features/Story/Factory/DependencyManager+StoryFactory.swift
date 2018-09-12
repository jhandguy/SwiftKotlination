protocol StoryFactory {
    func makeStoryBoundFactory(for story: Story) -> StoryBoundFactoryProtocol
}

// MARK: - Protocol Methods

extension DependencyManager: StoryFactory {
    func makeStoryBoundFactory(for story: Story) -> StoryBoundFactoryProtocol {
        return StoryBoundFactory(story: story)
    }
}
