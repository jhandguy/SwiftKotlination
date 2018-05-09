import UIKit
import RxSwift

struct StoryViewModel {
    private(set) var repository: StoryRepositoryProtocol
}

extension StoryViewModel {
    var backgroundColor: UIColor {
        return .black
    }
    
    var story: Observable<Story> {
        return repository.story
    }
}
