import XCTest
import RxSwift
@testable import SwiftKotlination

final class StoryRepositoryMock: StoryRepositoryProtocol {
    var storyStub: StoryStub
    
    init(storyStub: StoryStub = .failure(.timeout)) {
        self.storyStub = storyStub
    }
    
    enum StoryStub {
        case success(Story)
        case failure(RxError)
    }
    
    var story: Observable<Story> {
        switch storyStub {
        case .success(let story):
            return Observable.just(story)
        case .failure(let error):
            return Observable.error(error)
        }
    }
    
}
