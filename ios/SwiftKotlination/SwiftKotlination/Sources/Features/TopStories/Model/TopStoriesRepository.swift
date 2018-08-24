import Foundation

protocol TopStoriesRepositoryProtocol {
    func stories(_ observer: @escaping Observer<[Story]>)
    func fetchStories()
}

struct TopStoriesRepository: TopStoriesRepositoryProtocol {
    let apiClient: APIClientProtocol
    
    func stories(_ observer: @escaping Observer<[Story]>) {
        apiClient
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    do {
                        let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                        return observer(.success(topStories.results))
                    } catch {
                        return observer(.failure(error))
                    }
                    
                case .failure(let error):
                    return observer(.failure(error))
                }
        }
    }
    
    func fetchStories() {
        apiClient.execute(.fetchTopStories)
    }
}
