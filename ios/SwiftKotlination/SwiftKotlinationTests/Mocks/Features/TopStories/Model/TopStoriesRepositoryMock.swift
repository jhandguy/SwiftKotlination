import XCTest
import RxSwift
@testable import SwiftKotlination

final class TopStoriesRepositoryMock: TopStoriesRepositoryProtocol {
    
    var storiesStub: StoriesStub
    
    init(storiesStub: StoriesStub = .failure(.timeout)) {
        self.storiesStub = storiesStub
    }
    
    enum StoriesStub {
        case success([Story])
        case failure(RxError)
    }
    
    var stories: Observable<[Story]> {
        switch storiesStub {
        case .success(let stories):
            return Observable.just(stories)
        case .failure(let error):
            return Observable.error(error)
        }
    }
    
}
