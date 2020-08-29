public protocol StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol
    func makeStoryViewController(for story: Story) -> StoryViewController
}
