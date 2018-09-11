import XCTest
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {

    var sut: StoryViewModel!

    func testStoryViewModelFetchesStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(storyResult: .success(story), imageResult: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(story: story, factory: factory)

        sut
            .story { result in
                switch result {
                case .success(let newStory):
                    XCTAssertEqual(newStory, story)

                case .failure(let error):
                    XCTFail("Fetch Story should succeed, found error \(error)")
                }
        }
    }

    func testStoryViewModelFetchesStoryUnsuccesfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(storyResult: .failure(NetworkError.invalidResponse), imageResult: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(story: story, factory: factory)

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

        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(storyResult: .failure(NetworkError.invalidResponse), imageResult: .success(expectedImage))
        sut = StoryViewModel(story: story, factory: factory)

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
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(storyResult: .failure(NetworkError.invalidResponse), imageResult: .failure(NetworkError.invalidResponse))
        sut = StoryViewModel(story: story, factory: factory)

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
