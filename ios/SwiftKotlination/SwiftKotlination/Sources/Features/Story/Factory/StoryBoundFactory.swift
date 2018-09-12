protocol StoryBoundFactoryProtocol {
    func makeStoryManager() -> StoryManagerProtocol
}

struct StoryBoundFactory {
    let story: Story
}

// MARK: - Protocol Methods

extension StoryBoundFactory: StoryBoundFactoryProtocol {
    func makeStoryManager() -> StoryManagerProtocol {
        return StoryManager(story: story)
    }
}
