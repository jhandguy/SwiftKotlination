import Foundation
import NetworkKit
import StoryKit

public protocol TopStoriesManagerProtocol {
    @discardableResult
    func stories(_ observer: @escaping Observer<[Story]>) -> Disposable
    func fetchStories()
}

public struct TopStoriesManager {
    let networkManager: NetworkManagerProtocol

    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension TopStoriesManager: TopStoriesManagerProtocol {
    @discardableResult
    public func stories(_ observer: @escaping Observer<[Story]>) -> Disposable {
        networkManager
            .observe(.fetchTopStories) { result in
                switch result {
                case let .success(data):
                    do {
                        let topStories = try JSONDecoder().decode(TopStories.self, from: data)
                        observer(.success(topStories.results))
                    } catch {
                        observer(.failure(error))
                    }

                case let .failure(error):
                    observer(.failure(error))
                }
            }
    }

    public func fetchStories() {
        networkManager.execute(.fetchTopStories)
    }
}
