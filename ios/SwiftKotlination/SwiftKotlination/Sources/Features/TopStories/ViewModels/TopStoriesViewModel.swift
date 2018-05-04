import UIKit
import RxSwift

protocol TopStoriesViewModelDelegate: class {
    
}

final class TopStoriesViewModel {
    weak var delegate: TopStoriesViewModelDelegate?
    var repository: TopStoriesRepositoryProtocol
    
    init(_ repository: TopStoriesRepositoryProtocol) {
        self.repository = repository
    }
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
