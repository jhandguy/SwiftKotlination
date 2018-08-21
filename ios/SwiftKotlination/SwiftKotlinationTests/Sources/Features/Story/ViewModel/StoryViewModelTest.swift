import XCTest
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {
    
    var sut: StoryViewModel!
    
    func testStoryViewModelStorySuccess() {
        let expectedStory = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryViewModel(repository: StoryRepositoryMock(result: .success(expectedStory)))
        sut
            .story { result in
                switch result {
                case .success(let story):
                    XCTAssertEqual(story, expectedStory)
                
                case .failure(let error):
                    XCTFail("Get Story should succeed, found error \(error)")
                }
            }
    }
    
    func testStoryViewModelStoryFailure() {
        sut = StoryViewModel(repository: StoryRepositoryMock(result: .failure(.unknown)))
        
        sut
            .story { result in
                switch result {
                case .success(let story):
                    XCTFail("Get Story should fail, found story \(story)")
                    
                case .failure(let error):
                    XCTAssertEqual(error, .unknown)
                }
            }
    }
}
