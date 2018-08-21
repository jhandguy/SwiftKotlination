protocol StoryRepositoryProtocol {
    func story(_ closure: @escaping (Result<Story>) -> Void)
}

struct StoryRepository: StoryRepositoryProtocol {
    private let story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    func story(_ closure: @escaping (Result<Story>) -> Void) {
        closure(.success(story))
    }
}
