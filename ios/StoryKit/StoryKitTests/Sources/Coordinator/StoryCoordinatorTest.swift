@testable import StoryKit
import TestKit
import XCTest

final class StoryCoordinatorTest: XCTestCase {
    private var sut: StoryCoordinator!

    override func setUp() {
        super.setUp()

        let factory = StoryFactoryMock()
        sut = StoryCoordinator(factory: factory)
    }

    func testStoryCoordinatorStartsSuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let viewController = sut.start(with: story)

        XCTAssertTrue(viewController is StoryViewController)
    }

    func testStoryCoordinatorOpensUrlSuccessfully() {
        let delegate = StoryCoordinatorDelegateMock()
        sut.delegate = delegate

        let url = "url"
        sut.storyViewController(StoryViewController(), didTouchUpInsideUrl: url)

        XCTAssertEqual(delegate.openedUrl, url)
    }
}
