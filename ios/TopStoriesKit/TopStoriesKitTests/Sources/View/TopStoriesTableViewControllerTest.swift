import NetworkKit
import StoryKit
import TestKit
@testable import TopStoriesKit
import XCTest

final class TopStoriesTableViewControllerTest: XCTestCase {
    private var sut: TopStoriesTableViewController!

    func testTopStoriesTableViewControllerFetchesTopStoriesSuccessfully() {
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

        sut = factory.makeTopStoriesTableViewController()

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)
    }

    func testTopStoriesTableViewControllerFetchesTopStoriesUnsuccessfully() {
        let factory = TopStoriesFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .failure(NetworkError.invalidResponse))
        )

        sut = factory.makeTopStoriesTableViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertTrue(sut.tableView.visibleCells.isEmpty)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testTopStoriesTableViewControllerFetchesTopStoryImageSuccessfully() throws {
        let data = try XCTUnwrap(File("28DC-nafta-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: data))
        let multimedia = Multimedia(url: "url", format: .small)
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: [multimedia]
        )
        let factory = TopStoriesFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story])),
            imageManager: ImageManagerMock(result: .success(expectedImage))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.disposeBag.disposables.isEmpty)
        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        let cell = try XCTUnwrap(sut.tableView.visibleCells.first as? TopStoriesTableViewCell)
        let image = try XCTUnwrap(cell.multimediaImageView.image)
        XCTAssertEqual(expectedImage.pngData(), image.pngData())
        XCTAssertFalse(cell.multimediaImageView.isHidden)

        sut.viewWillDisappear(false)

        XCTAssertTrue(sut.disposeBag.disposables.isEmpty)
    }

    func testTopStoriesTableViewControllerFetchesTopStoryImageUnsuccessfully() throws {
        let multimedia = Multimedia(url: "url", format: .small)
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: [multimedia]
        )
        let factory = TopStoriesFactoryMock(
            topStoriesManager: TopStoriesManagerMock(result: .success([story]))
        )

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.tableView.visibleCells.isEmpty)

        let cell = try XCTUnwrap(sut.tableView.visibleCells.first as? TopStoriesTableViewCell)
        XCTAssertTrue(cell.multimediaImageView.isHidden)
    }

    func testTopStoriesTableViewControllerOpensStorySuccessfully() {
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

        sut = factory.makeTopStoriesTableViewController()
        sut.viewDidLoad()

        sut.viewWillAppear(false)

        let delegate = TopStoriesTableViewControllerDelegateMock()
        sut.delegate = delegate
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(delegate.selectedStory, story)
    }
}
