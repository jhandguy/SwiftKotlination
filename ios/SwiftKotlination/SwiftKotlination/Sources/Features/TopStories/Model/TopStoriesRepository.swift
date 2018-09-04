import Foundation

protocol TopStoriesRepositoryProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable
    func fetchStories()
}

struct TopStoriesRepository {
    let apiClient: APIClientProtocol
}

// MARK: - Protocol Methods

extension TopStoriesRepository: TopStoriesRepositoryProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        return apiClient
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    do {
                        let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                        observer(.success(topStories.results))
                    } catch {
                        observer(.failure(error))
                    }

                case .failure(let error):
                    observer(.failure(error))
                }
        }
    }

    func fetchStories() {
        apiClient.execute(.fetchTopStories)
    }
}
