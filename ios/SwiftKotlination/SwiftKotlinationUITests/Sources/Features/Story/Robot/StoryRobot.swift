import XCTest

final class StoryRobot: Robot {

    // MARK: - Internal Methods

    @discardableResult
    func start(with story: Story, and sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) -> Self {
        return start(.openStory(story), with: sessionMock, and: animationStub)
    }

    @discardableResult
    func checkStoryImage() -> Self {
        XCTAssertEqual(app.images.count, 1)
        return assert(app.images.firstMatch, [.exists])
    }

    @discardableResult
    func checkStoryTitle(contains storyTitle: String) -> Self {
        return assert(app.staticTexts[storyTitle], [.isHittable])
    }

    @discardableResult
    func checkStoryAbstract(contains storyAbstract: String) -> Self {
        return assert(app.staticTexts[storyAbstract], [.isHittable])
    }

    @discardableResult
    func checkStoryByline(contains storyByline: String) -> Self {
        return assert(app.staticTexts[storyByline], [.isHittable])
    }

    @discardableResult
    func openSafari() -> SafariRobot {
        tap(app.buttons["Read more..."])
        return SafariRobot(app)
    }

    @discardableResult
    func closeStory() -> Self {
        return tap(app.buttons["Top Stories"])
    }
}
