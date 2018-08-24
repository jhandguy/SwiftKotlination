protocol StoryRepositoryProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

struct StoryRepository: StoryRepositoryProtocol {
    private let story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
