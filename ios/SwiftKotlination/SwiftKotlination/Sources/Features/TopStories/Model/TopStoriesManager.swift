import Foundation

protocol TopStoriesManagerProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable
    func fetchStories()
}

struct TopStoriesManager {
    let networkManager: NetworkManagerProtocol
}

// MARK: - Protocol Methods

extension TopStoriesManager: TopStoriesManagerProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        return networkManager
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
        networkManager.execute(.fetchTopStories)
    }
}
