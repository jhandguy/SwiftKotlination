import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {

    var sut: StoryViewController!

    func testStoryViewControllerFetchesStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock(
            storyBoundFactory: StoryBoundFactoryMock(
                storyManager: StoryManagerMock(result: .success(story))
            )
        )

        sut = factory.makeStoryViewController(for: story)
        _ = sut.view

        sut.viewWillAppear(false)

        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.titleLabel.text, story.title)
        XCTAssertEqual(sut.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.bylineLabel.text, story.byline)
    }

    func testStoryViewControllerFetchesStoryUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock()

        sut = factory.makeStoryViewController(for: story)
        _ = sut.view

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewWillAppear(false)

        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }

    func testStoryViewControllerFetchesStoryImageSuccessfully() {
        guard
            let data = File("28DC-nafta-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {

                XCTFail("Invalid image")
                return
        }

        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let factory = ViewControllerFactoryMock(
            imageManager: ImageManagerMock(result: .success(expectedImage)),
            storyBoundFactory: StoryBoundFactoryMock(storyManager: StoryManagerMock(result: .success(story)))
        )

        sut = factory.makeStoryViewController(for: story)
        _ = sut.view

        sut.viewWillAppear(false)

        XCTAssertFalse(sut.disposeBag.disposables.isEmpty)
        XCTAssertFalse(sut.multimediaImageView.isHidden)

        guard let image = sut.multimediaImageView.image else {
            XCTFail("Invalid image view")
            return
        }

        XCTAssertEqual(image.pngData(), expectedImage.pngData())

        sut.viewWillDisappear(false)

        XCTAssertTrue(sut.disposeBag.disposables.isEmpty)
    }

    func testStoryViewControllerFetchesStoryImageUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let factory = ViewControllerFactoryMock(
            storyBoundFactory: StoryBoundFactoryMock(
                storyManager: StoryManagerMock(result: .success(story))
            )
        )

        sut = factory.makeStoryViewController(for: story)
        _ = sut.view

        sut.viewWillAppear(false)

        XCTAssertTrue(sut.multimediaImageView.isHidden)
    }

    func testStoryViewControllerOpensUrlSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = ViewControllerFactoryMock(
            storyBoundFactory: StoryBoundFactoryMock(
                storyManager: StoryManagerMock(result: .success(story))
            )
        )

        sut = factory.makeStoryViewController(for: story)
        _ = sut.view

        sut.viewWillAppear(false)

        let coordinator = CoordinatorMock()
        sut.coordinator = coordinator
        sut.urlButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(coordinator.isUrlOpened)
    }
}
