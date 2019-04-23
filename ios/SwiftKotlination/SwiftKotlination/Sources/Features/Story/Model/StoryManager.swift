protocol StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

struct StoryManager {
    let story: Story
}

extension StoryManager: StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
