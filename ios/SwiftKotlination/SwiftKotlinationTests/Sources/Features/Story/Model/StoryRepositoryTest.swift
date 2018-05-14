import XCTest
import RxSwift
@testable import SwiftKotlination

final class StoryRepositoryTest: XCTestCase {
    
    var sut: StoryRepository!
    
    func testStoryRepositoryStory() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryRepository(story: story)
        sut
            .story
            .subscribe(
                onNext: { XCTAssertEqual($0, story) },
                onError: { XCTFail("Story should succeed, found error \($0)") })
            .dispose()
    }
}
