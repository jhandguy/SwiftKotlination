protocol StoryRepositoryProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

struct StoryRepository: StoryRepositoryProtocol {
    let story: Story
    
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
