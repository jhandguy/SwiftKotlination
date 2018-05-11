import XCTest
import RxSwift
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {
    
    var sut: StoryViewModel!
    
    func testStoryViewModelStorySuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryViewModel(repository:
            StoryRepositoryMock(storyStub: .success(story)))
        sut
            .story
            .subscribe(
                onNext: { XCTAssertEqual($0, story) },
                onError: { XCTFail("Get Story should succeed, found error \($0)") })
            .dispose()
    }
    
    func testStoryViewModelStoryFailure() {
        sut = StoryViewModel(repository:
            StoryRepositoryMock(storyStub: .failure(.unknown)))
        sut
            .story
            .subscribe(
                onNext: { XCTFail("Get Story should fail, found story \($0)") },
                onError: {
                    guard let error = $0 as? RxError else {
                        XCTFail("Error \($0) should be of type RxError")
                        return
                    }
                    if case .unknown = error {
                        return
                    }
                    XCTFail("Error \(error) should be .unknown")
                })
            .dispose()
    }
}
