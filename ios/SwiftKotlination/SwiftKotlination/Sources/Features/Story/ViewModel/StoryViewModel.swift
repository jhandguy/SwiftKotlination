struct StoryViewModel {
    private let repository: StoryRepositoryProtocol
    
    init(repository: StoryRepositoryProtocol) {
        self.repository = repository
    }
}

extension StoryViewModel {
    func story(_ closure: @escaping (Result<Story>) -> Void) {
        return repository.story(closure)
    }
}
