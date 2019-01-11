protocol StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol
    func makeStoryViewController(for story: Story) -> StoryViewController
}

// MARK: - Protocol Methods

extension DependencyManager: StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol {
        return StoryManager(story: story)
    }

    func makeStoryViewController(for story: Story) -> StoryViewController {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(factory: self, story: story)

        return viewController
    }
}
