import XCTest
@testable import SwiftKotlination

final class TopStoriesViewModelTest: XCTestCase {
    
    var sut: TopStoriesViewModel!
    
    func testTopStoriesViewModelStoriesSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesViewModel(repository: repository)
        
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
        let repository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(repository: repository)
        
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Get Stories should fail, found stories \(stories)")
                    
                case .failure(let error):
                    guard let error = error as? NetworkError else {
                        XCTFail("Invalid error")
                        return
                    }
                    XCTAssertEqual(error, .invalidResponse)
                }
            }
    }
    
    func testTopStoriesViewModelReloadSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story])) { result in
            switch result {
            case .success(let stories):
                XCTAssertEqual(stories.count, 1)
                XCTAssertEqual(stories.first, story)
                
            case .failure(let error):
                XCTFail("Reload stories should succeed, found error \(error)")
            }
        }
        sut = TopStoriesViewModel(repository: repository)
        
        sut.reload()
    }
    
    func testTopStoriesViewModelReloadFailure() {
        let repository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse)) { result in
            switch result {
            case .success(let stories):
                XCTFail("Reload stories should fail, found stories \(stories)")
                
            case .failure(let error):
                guard let error = error as? NetworkError else {
                    XCTFail("Invalid error")
                    return
                }
                XCTAssertEqual(error, .invalidResponse)
            }
        }
        sut = TopStoriesViewModel(repository: repository)
        
        sut.reload()
    }
}
