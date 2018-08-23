protocol StoryRepositoryProtocol {
    func story(_ closure: @escaping Observable<Story>)
}

struct StoryRepository: StoryRepositoryProtocol {
    private let story: Story
    
    init(story: Story) {
        self.story = story
    }
    
    func story(_ closure: @escaping Observable<Story>) {
        closure(.success(story))
    }
}
