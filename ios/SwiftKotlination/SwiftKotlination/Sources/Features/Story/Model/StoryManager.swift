protocol StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

struct StoryManager {
    let story: Story
}

// MARK: - Protocol Methods

extension StoryManager: StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
