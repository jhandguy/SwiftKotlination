import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {

    var sut: StoryViewController!

    func testStoryViewControllerFetchesStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = StoryFactoryMock(
            storyManager: StoryManagerMock(result: .success(story))
        )

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.storyView.titleLabel.text, story.title)
        XCTAssertEqual(sut.storyView.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.storyView.bylineLabel.text, story.byline)
    }

    func testStoryViewControllerFetchesStoryUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = StoryFactoryMock()

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewWillAppear(false)

        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testStoryViewControllerFetchesStoryImageSuccessfully() throws {
        let data = try require(File("28DC-nafta-thumbLarge", .jpg).data)
        let expectedImage = try require(UIImage(data: data))

        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let factory = StoryFactoryMock(
            storyManager: StoryManagerMock(result: .success(story)),
            imageManager: ImageManagerMock(result: .success(expectedImage))
        )

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertFalse(sut.disposeBag.disposables.isEmpty)
        XCTAssertFalse(sut.storyView.multimediaImageView.isHidden)

        let image = try require(sut.storyView.multimediaImageView.image)

        XCTAssertEqual(image.pngData(), expectedImage.pngData())

        sut.viewWillDisappear(false)

        XCTAssertTrue(sut.disposeBag.disposables.isEmpty)
    }

    func testStoryViewControllerFetchesStoryImageUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let factory = StoryFactoryMock(
            storyManager: StoryManagerMock(result: .success(story))
        )

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertTrue(sut.storyView.multimediaImageView.isHidden)
    }

    func testStoryViewControllerOpensUrlSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = StoryFactoryMock(
            storyManager: StoryManagerMock(result: .success(story))
        )

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        let coordinator = CoordinatorMock()
        sut.coordinator = coordinator
        sut.storyView.urlButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(coordinator.isUrlOpened)
    }
}
