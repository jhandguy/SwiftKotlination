import XCTest
@testable import SwiftKotlination

final class TopStoriesViewModelTest: XCTestCase {
    
    var sut: TopStoriesViewModel!
    
    func testTopStoriesViewModelFetchesTopStoriesSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story]))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
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
    
    func testTopStoriesViewModelFetchesTopStoriesUnsuccessfully() {
        let topStoriesRepository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
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
    
    func testTopStoriesViewModelReloadsSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story])) { result in
            switch result {
            case .success(let stories):
                XCTAssertEqual(stories.count, 1)
                XCTAssertEqual(stories.first, story)
                
            case .failure(let error):
                XCTFail("Reload stories should succeed, found error \(error)")
            }
        }
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
        sut.reload()
    }
    
    func testTopStoriesViewModelReloadsUnsuccessfully() {
        let topStoriesRepository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse)) { result in
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
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
        sut.reload()
    }
}
