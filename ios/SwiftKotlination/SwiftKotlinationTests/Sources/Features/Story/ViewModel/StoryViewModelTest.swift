import XCTest
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {
    
    var sut: StoryViewModel!
    
    func testStoryViewModelFetchesStorySuccessfully() {
        let expectedStory = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let storyRepository = StoryRepositoryMock(result: .success(expectedStory))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
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
    
    func testStoryViewModelFetchesStoryUnsuccesfully() {
        let storyRepository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut
            .story { result in
                switch result {
                case .success(let story):
                    XCTFail("Fetch Story should fail, found story \(story)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
        }
    }
    
    func testStoryViewModelFetchesStoryImageSuccessfully() {
        guard
            let data = File("28DC-nafta-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {
                
            XCTFail("Invalid image")
            return
        }
        
        let imageRepository = ImageRepositoryMock(result: .success(expectedImage))
        let storyRepository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut
            .image(with: "") { result in
                switch result {
                case .success(let image):
                    XCTAssertEqual(UIImagePNGRepresentation(image), UIImagePNGRepresentation(expectedImage))
                    
                case .failure(let error):
                    XCTFail("Fetch Story Image should succeed, found error \(error)")
                }
        }
    }
    
    func testStoryViewModelFetchesStoryImageUnsuccessfully() {
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let storyRepository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut
            .image(with: "") { result in
                switch result {
                case .success(let image):
                    XCTFail("Fetch Story Image should fail, found image \(image)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
        }
    }
}
