import XCTest
import SafariServices
@testable import SwiftKotlination

final class CoordinatorTest: XCTestCase {
    
    var sut: Coordinator!
    
    func testCoordinatorStartsWithTopStoriesTableViewController() {
        sut = Coordinator(window: UIWindow(), apiClient: APIClient())
        sut.start()
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        XCTAssertTrue(sut.navigationController.viewControllers.first is TopStoriesTableViewController)
    }
    
    func testCoordinatorOpensStoryWithStoryViewController() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = Coordinator(window: UIWindow(), apiClient: APIClient())
        sut.open(story)
        XCTAssertEqual(sut.navigationController.viewControllers.count, 1)
        XCTAssertTrue(sut.navigationController.viewControllers.first is StoryViewController)
    }
    
    func testCoordinatorOpensUrlWithSafariViewController() {
        guard let url = URL(string: "https://test.com") else {
            XCTFail("Invalid URL")
            return
        }
        sut = Coordinator(window: UIWindow(), apiClient: APIClient())
        sut.open(url)
        XCTAssertTrue(sut.navigationController.presentedViewController is SFSafariViewController)
    }
}
