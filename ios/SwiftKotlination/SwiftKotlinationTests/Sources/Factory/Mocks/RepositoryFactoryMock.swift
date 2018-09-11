import UIKit
@testable import SwiftKotlination

final class RepositoryFactoryMock {
    let topStoriesRepository: TopStoriesRepositoryMock
    let storyRepository: StoryRepositoryMock
    let imageRepository: ImageRepositoryMock

    init(topStoriesResult: Result<[Story]> = .failure(NetworkError.invalidRequest),
         storyResult: Result<Story> = .failure(NetworkError.invalidRequest),
         imageResult: Result<UIImage> = .failure(NetworkError.invalidRequest)) {

        self.topStoriesRepository = TopStoriesRepositoryMock(result: topStoriesResult)
        self.storyRepository = StoryRepositoryMock(result: storyResult)
        self.imageRepository = ImageRepositoryMock(result: imageResult)
    }
}

extension RepositoryFactoryMock: RepositoryFactory {
    func makeTopStoriesRepository() -> TopStoriesRepositoryProtocol {
        return topStoriesRepository
    }

    func makeStoryRepository(for story: Story) -> StoryRepositoryProtocol {
        return storyRepository
    }

    func makeImageRepository() -> ImageRepositoryProtocol {
        return imageRepository
    }
}
