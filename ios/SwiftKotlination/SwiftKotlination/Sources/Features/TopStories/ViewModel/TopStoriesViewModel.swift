final class TopStoriesViewModel {
    internal let repository: TopStoriesRepositoryProtocol
    private(set) var stories: [Story]
    
    init(repository: TopStoriesRepositoryProtocol) {
        self.repository = repository
        self.stories = []
    }
}

extension TopStoriesViewModel {
    func stories(_ closure: @escaping Observable<[Story]>) {
        repository.stories { [weak self] result in
            switch result {
            case .success(let stories):
                self?.stories = stories
                
            case .failure:
                break
            }
            closure(result)
        }
    }
    
    func reload() {
        repository.fetchStories()
    }
}
