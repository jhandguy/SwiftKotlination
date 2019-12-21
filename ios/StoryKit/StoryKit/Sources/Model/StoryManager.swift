import NetworkKit

public protocol StoryManagerProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

public struct StoryManager {
    let story: Story

    public init(story: Story) {
        self.story = story
    }
}

extension StoryManager: StoryManagerProtocol {
    public func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
