import XCTest
@testable import SwiftKotlination

final class DependencyManagerTest: XCTestCase {

    var sut: DependencyManager!

    override func setUp() {
        super.setUp()

        let networkManager = NetworkManagerMock(result: .failure(NetworkError.invalidRequest))
        sut = DependencyManager(networkManager: networkManager)
    }

    func testDependencyManagerMakesTopStoriesTableViewControllerSuccessfully() {
        let viewController = sut.makeTopStoriesTableViewController()
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNil(viewController.coordinator)
    }

    func testDependencyManagerMakesStoryViewControllerSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let viewController = sut.makeStoryViewController(for: story)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNil(viewController.coordinator)
    }
}
