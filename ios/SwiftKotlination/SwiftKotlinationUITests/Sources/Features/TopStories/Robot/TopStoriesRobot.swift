import XCTest

final class TopStoriesRobot: Robot {

    // MARK: - Private Properties

    private lazy var table = app.tables.firstMatch

    // MARK: - Internal Methods

    @discardableResult
    func start(with sessionMock: URLSessionMock = URLSessionMock(), and animationStub: AnimationStub = .disableAnimations) -> Self {
        start(.start, with: sessionMock, and: animationStub)

        return self
    }

    @discardableResult
    func checkTopStoriesCount(is count: Int) -> Self {
        assert(table, [.isHittable])
        assert(table, [.has(count, .cell)])

        return self
    }

    @discardableResult
    func forEach(topStories indexes: [Int], _ completion: (TopStoriesRobot, Int) -> Void) -> Self {
        indexes.forEach { index in
            completion(self, index)
        }

        return self
    }

    @discardableResult
    func checkTopStoryTitle(contains title: String, at index: Int) -> Self {
        let cell = table.cells.element(boundBy: index)
        let label = cell.staticTexts["TopStoriesTableViewCell.titleLabel"]
        assert(label, [.isHittable])
        assert(label, [.contains(title)])

        return self
    }

    @discardableResult
    func checkTopStoryByline(contains byline: String, at index: Int) -> Self {
        let cell = table.cells.element(boundBy: index)
        let label = cell.staticTexts["TopStoriesTableViewCell.bylineLabel"]
        assert(label, [.isHittable])
        assert(label, [.contains(byline)])

        return self
    }

    @discardableResult
    func openStory(at index: Int) -> StoryRobot {
        let cell = table.cells.element(boundBy: index)
        tap(cell)

        return StoryRobot(app)
    }

    @discardableResult
    func refreshTopStories() -> Self {
        refresh(inside: table)

        return self
    }
}
