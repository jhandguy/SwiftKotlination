import XCTest
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {
    
    var sut: StoryViewModel!
    
    func testStoryViewModelFetchesStorySuccessfully() {
        let expectedStory = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let storyRepository = StoryRepositoryMock(result: .success(expectedStory))
        sut = StoryViewModel(storyRepository: storyRepository)
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
    
    func testStoryViewModelFetchesStoryUnsuccesfully() {
        let storyRepository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(storyRepository: storyRepository)
        
        sut
            .story { result in
                switch result {
                case .success(let story):
                    XCTFail("Get Story should fail, found story \(story)")
                    
                case .failure(let error):
                    guard let error = error as? NetworkError else {
                        XCTFail("Invalid error")
                        return
                    }
                    XCTAssertEqual(error, .invalidResponse)
                }
            }
    }
}
