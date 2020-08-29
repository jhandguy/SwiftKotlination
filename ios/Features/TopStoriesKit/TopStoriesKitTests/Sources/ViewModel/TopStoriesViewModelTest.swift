import NetworkKit
import StoryKit
import TestKit
@testable import TopStoriesKit
import XCTest

final class TopStoriesViewModelTest: XCTestCase {
    private var sut: TopStoriesViewModel!

    func testTopStoriesViewModelFetchesTopStoriesSuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = TopStoriesFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )
        sut = TopStoriesViewModel(factory: factory)

        sut
            .stories { result in
                switch result {
                case let .success(stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)

                case let .failure(error):
                    XCTFail("Fetch Stories should succeed, found error \(error)")
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoriesUnsuccessfully() {
        let factory = TopStoriesFactoryMock()
        sut = TopStoriesViewModel(factory: factory)

        sut
            .stories { result in
                switch result {
                case let .success(stories):
                    XCTFail("Fetch Stories should fail, found stories \(stories)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoryImageSuccessfully() throws {
        let imageData = try XCTUnwrap(File("28DC-nafta-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: imageData))
        let factory = TopStoriesFactoryMock(
            imageManager: ImageManagerMock(result: .success(imageData))
        )
        sut = TopStoriesViewModel(factory: factory)

        sut
            .image(with: "") { result in
                switch result {
                case let .success(image):
                    XCTAssertEqual(image.pngData(), expectedImage.pngData())

                case let .failure(error):
                    XCTFail("Fetch TopStory Image should succeed, found error \(error)")
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoryImageUnsuccessfully() {
        let factory = TopStoriesFactoryMock()
        sut = TopStoriesViewModel(factory: factory)

        sut
            .image(with: "") { result in
                switch result {
                case let .success(image):
                    XCTFail("Fetch TopStory Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testTopStoriesViewModelFetchesInvalidTopStoryImageUnsuccessfully() {
        let data = Data()
        let factory = TopStoriesFactoryMock(
            imageManager: ImageManagerMock(result: .success(data))
        )
        sut = TopStoriesViewModel(factory: factory)

        sut
            .image(with: "") { result in
                switch result {
                case let .success(image):
                    XCTFail("Fetch TopStory Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidData)
                }
            }
    }

    func testTopStoriesViewModelRefreshsSuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let factory = TopStoriesFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )
        sut = TopStoriesViewModel(factory: factory)

        var times = 0

        sut
            .stories { result in
                switch result {
                case let .success(stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)

                case let .failure(error):
                    XCTFail("Refresh stories should succeed, found error \(error)")
                }
                times += 1
            }

        XCTAssertEqual(times, 1)

        sut.refresh()

        XCTAssertEqual(times, 2)
    }

    func testTopStoriesViewModelRefreshsUnsuccessfully() {
        let factory = TopStoriesFactoryMock()
        sut = TopStoriesViewModel(factory: factory)

        var times = 0

        sut
            .stories { result in
                switch result {
                case let .success(stories):
                    XCTFail("Refresh stories should fail, found stories \(stories)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }

        XCTAssertEqual(times, 1)

        sut.refresh()

        XCTAssertEqual(times, 2)
    }
}
