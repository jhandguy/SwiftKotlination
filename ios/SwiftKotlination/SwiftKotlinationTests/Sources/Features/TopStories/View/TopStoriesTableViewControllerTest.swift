import XCTest
@testable import SwiftKotlination

final class TopStoriesTableViewControllerTest: XCTestCase {

    var sut: TopStoriesTableViewController!

    func testTopStoriesTableViewControllerFetchesTopStoriesSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        factory.topStoriesManager.result = .success([])
        sut.refreshControl?.sendActions(for: .valueChanged)

        XCTAssertTrue(sut.tableView.visibleCells.isEmpty)
    }

    func testTopStoriesTableViewControllerFetchesTopStoriesUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        factory.topStoriesManager.result = .failure(NetworkError.invalidResponse)
        sut.refreshControl?.sendActions(for: .valueChanged)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testTopStoriesTableViewControllerFetchesTopStoryImageSuccessfully() {
        guard
            let data = File("28DC-nafta-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {

                XCTFail("Invalid image")
                return
        }
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "url", format: .small)])
        let factory = ViewControllerFactoryMock(
            imageManager: ImageManagerMock(result: .success(expectedImage)),
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.disposeBag.disposables.isEmpty)
        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        guard
            let cell = sut.tableView.visibleCells.first as? TopStoriesTableViewCell,
            let image = cell.multimediaImageView.image else {

                XCTFail("Invalid cell")
                return
        }

        XCTAssertEqual(UIImagePNGRepresentation(expectedImage), UIImagePNGRepresentation(image))
        XCTAssertFalse(cell.multimediaImageView.isHidden)

        sut.viewWillDisappear(false)

        XCTAssertTrue(sut.disposeBag.disposables.isEmpty)
    }

    func testTopStoriesTableViewControllerFetchesTopStoryImageUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "url", format: .small)])
        let factory = ViewControllerFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        guard let cell = sut.tableView.visibleCells.first as? TopStoriesTableViewCell else {
            XCTFail("Invalid cell")
            return
        }

        XCTAssertTrue(cell.multimediaImageView.isHidden)
    }

    func testTopStoriesTableViewControllerOpensStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        let coordinator = CoordinatorMock()
        sut.coordinator = coordinator
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertTrue(coordinator.isStoryOpened)
    }
}
