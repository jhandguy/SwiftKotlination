import NetworkKit
@testable import StoryKit
import TestKit
import XCTest

final class StoryViewModelTest: XCTestCase {
    private var sut: StoryViewModel!

    func testStoryViewModelFetchesStorySuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = StoryFactoryMock(
            storyManager: StoryManagerMock(result: .success(story)),
            imageManager: ImageManagerMock(result: .failure(NetworkError.invalidResponse))
        )
        sut = StoryViewModel(factory: factory, story: story)

        sut
            .story { result in
                switch result {
                case let .success(newStory):
                    XCTAssertEqual(newStory, story)

                case let .failure(error):
                    XCTFail("Fetch Story should succeed, found error \(error)")
                }
            }
    }

    func testStoryViewModelFetchesStoryUnsuccesfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = StoryFactoryMock()
        sut = StoryViewModel(factory: factory, story: story)

        sut
            .story { result in
                switch result {
                case let .success(story):
                    XCTFail("Fetch Story should fail, found story \(story)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testStoryViewModelFetchesStoryImageSuccessfully() throws {
        let data = try XCTUnwrap(File("28DC-nafta-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: data))

        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = StoryFactoryMock(
            imageManager: ImageManagerMock(result: .success(expectedImage))
        )
        sut = StoryViewModel(factory: factory, story: story)

        sut
            .image(with: "") { result in
                switch result {
                case let .success(image):
                    XCTAssertEqual(image.pngData(), expectedImage.pngData())

                case let .failure(error):
                    XCTFail("Fetch Story Image should succeed, found error \(error)")
                }
            }
    }

    func testStoryViewModelFetchesStoryImageUnsuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = StoryFactoryMock()
        sut = StoryViewModel(factory: factory, story: story)

        sut
            .image(with: "") { result in
                switch result {
                case let .success(image):
                    XCTFail("Fetch Story Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }
}
