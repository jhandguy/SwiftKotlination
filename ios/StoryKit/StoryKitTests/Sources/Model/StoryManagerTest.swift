@testable import StoryKit
import XCTest

final class StoryManagerTest: XCTestCase {
    private var sut: StoryManager!

    func testStoryManagerFetchesStorySuccessfully() {
        let expectedStory = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        sut = StoryManager(story: expectedStory)
        
        sut
            .story { result in
                switch result {
                case let .success(story):
                    XCTAssertEqual(story, expectedStory)

                case let .failure(error):
                    XCTFail("Fetch Story should succeed, found error \(error)")
                }
            }
    }
}
