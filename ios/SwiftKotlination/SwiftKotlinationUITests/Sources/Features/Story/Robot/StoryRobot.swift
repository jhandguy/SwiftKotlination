import NetworkKit
import StoryKit
import XCTest

final class StoryRobot: Robot {
    private lazy var stackView = app.otherElements["StoryView.stackView"]
    private lazy var multimediaImage = stackView.images["StoryView.multimediaImageView"]
    private lazy var titleLabel = stackView.staticTexts["StoryView.titleLabel"]
    private lazy var abstractLabel = stackView.staticTexts["StoryView.abstractLabel"]
    private lazy var bylineLabel = stackView.staticTexts["StoryView.bylineLabel"]
    private lazy var urlButton = stackView.buttons["StoryView.urlButton"]

    @discardableResult
    func start(with story: Story, and sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) -> Self {
        start(.openStory(story), with: sessionMock, and: animationStub)

        return self
    }

    @discardableResult
    func checkStoryImage() -> Self {
        assert(multimediaImage, [.exists])

        return self
    }

    @discardableResult
    func checkStoryTitle(contains storyTitle: String) -> Self {
        assert(titleLabel, [.isHittable, .contains(storyTitle)])

        return self
    }

    @discardableResult
    func checkStoryAbstract(contains storyAbstract: String) -> Self {
        assert(abstractLabel, [.isHittable, .contains(storyAbstract)])

        return self
    }

    @discardableResult
    func checkStoryByline(contains storyByline: String) -> Self {
        assert(bylineLabel, [.isHittable, .contains(storyByline)])

        return self
    }

    @discardableResult
    func openSafari() -> SafariRobot {
        tap(urlButton)

        return SafariRobot(app)
    }
}
