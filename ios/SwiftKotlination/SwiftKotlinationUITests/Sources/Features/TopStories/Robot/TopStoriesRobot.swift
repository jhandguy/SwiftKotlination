import XCTest

final class TopStoriesRobot: Robot {

    // MARK: - Internal Methods
    
    @discardableResult
    func checkTopStoriesTable(_ predicate: Predicate) -> Self {
        XCTAssertEqual(app.tables.count, 1)
        return assert(app.tables.firstMatch, predicate)
    }

    @discardableResult
    func checkTopStoriesCount(is count: Int) -> Self {
        XCTAssertEqual(app.tables.firstMatch.cells.count, count)
        return self
    }

    @discardableResult
    func checkTopStoryTitle(contains title: String) -> Self {
        return assert(app.staticTexts[title], .isHittable)
    }

    @discardableResult
    func checkTopStoryByline(contains byline: String) -> Self {
        return assert(app.staticTexts[byline], .isHittable)
    }

    @discardableResult
    func forTopStories(at indexes: [Int], _ completion: (TopStoriesRobot, Int) -> ()) -> Self {
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
}
