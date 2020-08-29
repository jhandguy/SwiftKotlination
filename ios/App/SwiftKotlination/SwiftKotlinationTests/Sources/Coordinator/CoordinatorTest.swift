import NetworkKit
import SafariServices
import StoryKit
@testable import SwiftKotlination
import TestKit
import TopStoriesKit
import XCTest

final class CoordinatorTest: XCTestCase {
    private var sut: Coordinator!

    override func setUp() {
        super.setUp()

        let factory = FactoryMock()
        let window = UIWindow()
        sut = Coordinator(factory: factory, window: window)
    }

    func testCoordinatorStartsWithTopStoriesTableViewControllerSuccessfully() {
        let topStoriesCoordinator = TopStoriesCoordinatorMock()
        sut.topStoriesCoordinator = topStoriesCoordinator

        sut.start()

        XCTAssertTrue(topStoriesCoordinator.isStarted)
    }

    func testCoordinatorOpensStoryWithStoryViewControllerSuccessfully() {
        let storyCoordinator = StoryCoordinatorMock()
        sut.storyCoordinator = storyCoordinator

        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        sut.open(story)

        XCTAssertTrue(storyCoordinator.isStarted)
        XCTAssertEqual(storyCoordinator.story, story)
    }

    func testCoordinatorOpensUrlWithSafariViewControllerSuccessfully() {
        let url = "https://test.com"

        sut.open(url)

        XCTAssertTrue(sut.navigationController.presentedViewController is SFSafariViewController)
    }
}
