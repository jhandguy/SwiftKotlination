struct StoryViewModel {
    private let repository: StoryRepositoryProtocol
    
    init(repository: StoryRepositoryProtocol) {
        self.repository = repository
    }
}

extension StoryViewModel {
    func story(_ closure: @escaping Observable<Story>) {
        return repository.story(closure)
    }
}
