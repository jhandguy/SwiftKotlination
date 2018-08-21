import Foundation

protocol TopStoriesRepositoryProtocol {
    func stories(_ closure: @escaping (Result<[Story]>) -> Void)
    func fetchStories()
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    let apiClient: APIClientProtocol
    
    func stories(_ closure: @escaping (Result<[Story]>) -> Void) {
        apiClient
            .subscribe(to: .fetchTopStories) { result in
                switch result {
                case .success(let data):
                    guard let topStories = try? JSONDecoder().decode(TopStories.self, from: data) else {
                        return closure(.success([]))
                    }
                    return closure(.success(topStories.results))
                    
                case .failure(let error):
                    return closure(.failure(error))
                }
        }
    }
    
    func fetchStories() {
        apiClient.execute(request: .fetchTopStories)
    }
}
