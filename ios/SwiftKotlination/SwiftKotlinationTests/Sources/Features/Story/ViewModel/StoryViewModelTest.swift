import XCTest
@testable import SwiftKotlination

final class StoryViewModelTest: XCTestCase {

    var sut: StoryViewModel!

    func testStoryViewModelFetchesStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = StoryFactoryMock(
            storyBoundFactory: StoryBoundFactoryMock(
                storyManager: StoryManagerMock(result: .success(story))
            ),
            imageManager: ImageManagerMock(result: .failure(NetworkError.invalidResponse))
        )
        sut = StoryViewModel(factory: factory, story: story)

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
        let factory = StoryFactoryMock()
        sut = StoryViewModel(factory: factory, story: story)

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
        let factory = StoryFactoryMock(
            imageManager: ImageManagerMock(result: .success(expectedImage))
        )
        sut = StoryViewModel(factory: factory, story: story)

        sut
            .image(with: "") { result in
                switch result {
                case .success(let image):
                    XCTAssertEqual(image.pngData(), expectedImage.pngData())

                case .failure(let error):
                    XCTFail("Fetch Story Image should succeed, found error \(error)")
                }
        }
    }

    func testStoryViewModelFetchesStoryImageUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = StoryFactoryMock()
        sut = StoryViewModel(factory: factory, story: story)

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
