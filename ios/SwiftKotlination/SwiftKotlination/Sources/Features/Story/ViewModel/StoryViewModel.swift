struct StoryViewModel {
    private let repository: StoryRepositoryProtocol
    
    init(repository: StoryRepositoryProtocol) {
        self.repository = repository
    }
}

extension StoryViewModel {
    func story(_ observer: @escaping Observer<Story>) {
        return repository.story(observer)
    }
}
