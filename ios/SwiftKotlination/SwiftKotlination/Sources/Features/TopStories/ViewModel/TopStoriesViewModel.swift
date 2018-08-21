final class TopStoriesViewModel {
    private let repository: TopStoriesRepositoryProtocol
    private(set) var stories: [Story]
    
    init(repository: TopStoriesRepositoryProtocol) {
        self.repository = repository
        self.stories = []
    }
}

extension TopStoriesViewModel {
    func stories(_ closure: @escaping (Result<[Story]>) -> Void) {
        repository.stories { [weak self] result in
            switch result {
            case .success(let stories):
                self?.stories = stories
                
            case .failure(let error):
                print(error)
            }
            closure(result)
        }
    }
    
    func reload() {
        repository.fetchStories()
    }
}
