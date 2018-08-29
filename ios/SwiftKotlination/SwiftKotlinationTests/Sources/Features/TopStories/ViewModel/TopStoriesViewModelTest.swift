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
    
    func testTopStoriesViewModelFetchesTopStoryImageSuccessfully() {
        guard let expectedData = File("28DC-nafta-thumbLarge", .jpg).data else {
            XCTFail("Invalid image")
            return
        }
        
        let imageRepository = ImageRepositoryMock(result: .success(expectedData))
        let topStoriesRepository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
        sut
            .image(with: "") { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, expectedData)
                    
                case .failure(let error):
                    XCTFail("Fetch TopStory Image should succeed, found error \(error)")
                }
            }
    }
    
    func testTopStoriesViewModelFetchesTopStoryImageUnsuccessfully() {
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let topStoriesRepository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
        sut
            .image(with: "") { result in
                switch result {
                case .success(let data):
                    XCTFail("Fetch TopStory Image should fail, found image with data \(data)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }
    
    func testTopStoriesViewModelRefreshsSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story])) { result in
            switch result {
            case .success(let stories):
                XCTAssertEqual(stories.count, 1)
                XCTAssertEqual(stories.first, story)
                
            case .failure(let error):
                XCTFail("Refresh stories should succeed, found error \(error)")
            }
        }
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        
        sut.refresh()
    }
    
    func testTopStoriesViewModelRefreshsUnsuccessfully() {
        let topStoriesRepository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse)) { result in
            switch result {
            case .success(let stories):
                XCTFail("Refresh stories should fail, found stories \(stories)")
                
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
        
        sut.refresh()
    }
}
