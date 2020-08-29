import StoryKit
import TestKit
@testable import TopStoriesKit
import XCTest

final class TopStoriesCoordinatorTest: XCTestCase {
    private var sut: TopStoriesCoordinator!

    override func setUp() {
        super.setUp()

        let factory = TopStoriesFactoryMock()
        sut = TopStoriesCoordinator(factory: factory)
    }

    func testTopStoriesCoordinatorStartsSuccessfully() {
        let viewController = sut.start()

        XCTAssertTrue(viewController is TopStoriesTableViewController)
    }

    func testTopStoriesCoordinatorOpensStorySuccessfully() {
        let delegate = TopStoriesCoordinatorDelegateMock()
        sut.delegate = delegate

        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        sut.topStoriesTableViewController(TopStoriesTableViewController(), didSelectStory: story)

        XCTAssertEqual(delegate.openedStory, story)
    }
}
