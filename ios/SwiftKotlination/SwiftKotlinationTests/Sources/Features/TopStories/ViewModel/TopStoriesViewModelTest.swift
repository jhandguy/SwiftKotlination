import XCTest
@testable import SwiftKotlination

final class TopStoriesViewModelTest: XCTestCase {
    
    var sut: TopStoriesViewModel!
    
    func testTopStoriesViewModelStoriesSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = TopStoriesViewModel(repository: TopStoriesRepositoryMock(result: .success([story])))
        
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)
                    
                case .failure(let error):
                    XCTFail("Get Stories should succeed, found error \(error)")
                }
            }
    }
    
    func testTopStoriesViewModelStoriesFailure() {
        sut = TopStoriesViewModel(repository: TopStoriesRepositoryMock(result: .failure(.unknown)))
        
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Get Stories should fail, found stories \(stories)")
                    
                case .failure(let error):
                    XCTAssertEqual(error, .unknown)
                }
            }
    }
    
}
