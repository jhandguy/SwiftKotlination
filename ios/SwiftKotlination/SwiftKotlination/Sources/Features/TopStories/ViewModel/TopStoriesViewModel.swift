import UIKit
import RxSwift

struct TopStoriesViewModel {
    private(set) var repository: TopStoriesRepositoryProtocol
}

extension TopStoriesViewModel {
    var stories: Observable<[Story]> {
        return repository.stories
    }
}
