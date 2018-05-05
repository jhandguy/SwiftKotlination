import UIKit
import RxSwift

struct TopStoriesViewModel {
    var repository: TopStoriesRepositoryProtocol
}

extension TopStoriesViewModel {
    var title: String {
        return "Top Stories"
    }
    
    var backgroundColor: UIColor {
        return .black
    }
    
    var stories: Observable<[Story]> {
        return repository.stories
    }
}
