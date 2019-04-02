import XCTest

final class TopStoriesRobot: Robot {

    // MARK: - Internal Methods

    @discardableResult
    func start(with sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) -> Self {
        return start(.start, with: sessionMock, and: animationStub)
    }

    @discardableResult
    func checkTopStoriesCount(is count: Int) -> Self {
        XCTAssertEqual(app.tables.count, 1)
        assert(app.tables.firstMatch, [.isHittable])
        XCTAssertEqual(app.tables.firstMatch.cells.count, count)
        return self
    }

    @discardableResult
    func checkTopStoryTitle(contains title: String) -> Self {
        return assert(app.staticTexts[title], [.isHittable])
    }

    @discardableResult
    func checkTopStoryByline(contains byline: String) -> Self {
        return assert(app.staticTexts[byline], [.isHittable])
    }

    @discardableResult
    func forEach(topStories indexes: [Int], _ completion: (TopStoriesRobot, Int) -> Void) -> Self {
        indexes.forEach { index in
            completion(self, index)
        }
        return self
    }

    @discardableResult
    func openStory(at index: Int) -> StoryRobot {
        tap(app.tables.firstMatch.cells.element(boundBy: index))
        return StoryRobot(app)
    }

    @discardableResult
    func refreshTopStories() -> Self {
        return refresh(inside: app.tables.firstMatch)
    }
}
