import XCTest
@testable import SwiftKotlination

final class StoryRepositoryTest: XCTestCase {
    
    var sut: StoryRepository!
    
    func testStoryRepositoryFetchesStorySuccessfully() {
        let expectedStory = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        sut = StoryRepository(story: expectedStory)
        sut
            .story { result in
                switch result {
                case .success(let story):
                    XCTAssertEqual(story, expectedStory)
                
                case .failure(let error):
                    XCTFail("Fetch Story should succeed, found error \(error)")
                }
            }
    }
}
