import XCTest
import RxSwift

@testable import SwiftKotlination

final class TopStoriesViewModelTest: XCTestCase {
    
    var sut: TopStoriesViewModel!
    
    func testTopStoriesViewModelStoriesSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = TopStoriesViewModel(repository: TopStoriesRepositoryMock(storiesStub: .success([story])))
        
        sut
            .stories
            .subscribe(
                onNext: {
                    XCTAssertEqual($0.count, 1)
                    XCTAssertEqual($0.first, story)
            },
                onError: { XCTFail("Get Stories should succeed, found error \($0)") })
            .dispose()
    }
    
    func testTopStoriesViewModelStoriesFailure() {
        sut = TopStoriesViewModel(repository: TopStoriesRepositoryMock(storiesStub: .failure(.unknown)))
        
        sut
            .stories
            .subscribe(
                onNext: { XCTFail("Get Stories should fail, found stories \($0)") },
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
