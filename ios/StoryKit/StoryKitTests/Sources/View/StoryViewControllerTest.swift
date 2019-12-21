import NetworkKit
@testable import StoryKit
import TestKit
import XCTest

final class StoryViewControllerTest: XCTestCase {
    private var sut: StoryViewController!

    func testStoryViewControllerFetchesStorySuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let manager = StoryManagerMock(result: .success(story))
        let factory = StoryFactoryMock(storyManager: manager)

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.storyView.titleLabel.text, story.title)
        XCTAssertEqual(sut.storyView.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.storyView.bylineLabel.text, story.byline)
    }

    func testStoryViewControllerFetchesStoryUnsuccessfully() {
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

        sut = factory.makeStoryViewController(for: story)

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testStoryViewControllerFetchesStoryImageSuccessfully() throws {
        let data = try XCTUnwrap(File("28DC-nafta-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: data))
        let multimedia = Multimedia(url: "", format: .large)
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: [multimedia]
        )
        let storyManager = StoryManagerMock(result: .success(story))
        let imageManager = ImageManagerMock(result: .success(expectedImage))
        let factory = StoryFactoryMock(storyManager: storyManager, imageManager: imageManager)

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertFalse(sut.disposeBag.disposables.isEmpty)
        XCTAssertFalse(sut.storyView.multimediaImageView.isHidden)

        let image = try XCTUnwrap(sut.storyView.multimediaImageView.image)

        XCTAssertEqual(image.pngData(), expectedImage.pngData())

        sut.viewWillDisappear(false)

        XCTAssertTrue(sut.disposeBag.disposables.isEmpty)
    }

    func testStoryViewControllerFetchesStoryImageUnsuccessfully() {
        let multimedia = Multimedia(url: "", format: .large)
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: [multimedia]
        )
        let manager = StoryManagerMock(result: .success(story))
        let factory = StoryFactoryMock(storyManager: manager)

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        XCTAssertTrue(sut.storyView.multimediaImageView.isHidden)
    }

    func testStoryViewControllerTapsUrlSuccessfully() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url",
            multimedia: []
        )
        let manager = StoryManagerMock(result: .success(story))
        let factory = StoryFactoryMock(storyManager: manager)

        sut = factory.makeStoryViewController(for: story)

        sut.viewDidLoad()
        sut.viewWillAppear(false)

        let delegate = StoryViewControllerDelegateMock()
        sut.delegate = delegate

        sut.didTouchUpInside(url: story.url)

        XCTAssertEqual(delegate.tappedUrl, story.url)
    }
}
