import Foundation

protocol TopStoriesRepositoryProtocol {
    var stories: [Story] { get }
    func stories(_ observer: @escaping Observer<[Story]>)
    func fetchStories()
}

final class TopStoriesRepository: TopStoriesRepositoryProtocol {
    private let apiClient: APIClientProtocol
    internal var stories: [Story]
    
    init(apiClient: APIClientProtocol, stories: [Story] = []) {
        self.apiClient = apiClient
        self.stories = stories
    }
    
    func stories(_ observer: @escaping Observer<[Story]>) {
        guard !stories.isEmpty else {
            apiClient
                .observe(.fetchTopStories) { [weak self] result in
                    switch result {
                    case .success(let data):
                        do {
                            let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                            self?.stories = topStories.results
                            observer(.success(topStories.results))
                        } catch {
                            observer(.failure(error))
                        }
                        
                    case .failure(let error):
                        observer(.failure(error))
                    }
            }
            return
        }
        
        return observer(.success(stories))
    }

    func fetchStories() {
        stories = []
        apiClient.execute(.fetchTopStories)
    }
}
