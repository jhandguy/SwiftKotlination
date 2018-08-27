protocol StoryRepositoryProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

final class StoryRepository: StoryRepositoryProtocol {
    var story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
