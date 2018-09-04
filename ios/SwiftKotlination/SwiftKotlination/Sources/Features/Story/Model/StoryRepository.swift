protocol StoryRepositoryProtocol {
    func story(_ observer: @escaping Observer<Story>)
}

struct StoryRepository {
    let story: Story
}

// MARK: - Protocol Methods

extension StoryRepository: StoryRepositoryProtocol {
    func story(_ observer: @escaping Observer<Story>) {
        observer(.success(story))
    }
}
