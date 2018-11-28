import XCTest

class Robot {
    
    // MARK: - Internal Properties

    static let defaultTimeout: Double = 10
    var app: XCUIApplication

    // MARK: - Initializer
    
    init(_ app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Internal Methods
    
    @discardableResult
    func tap(_ element: XCUIElement, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        assert(element, .isHittable)
        element.tap()
        return self
    }

    @discardableResult
    func assert(_ elements: XCUIElement, _ predicate: Predicate, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "\(predicate.rawValue) == true"), object: elements)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTFail("Element did not fulfill expectation for predicate: \(predicate.rawValue)")
            return self
        }
        return self
    }

    @discardableResult
    func refresh(inside element: XCUIElement) -> Self {
        guard [.table, .collectionView].contains(element.elementType) else {
            XCTFail("Cannot refresh inside element of type \(element.elementType)")
            return self
        }
        let cell = element.cells.firstMatch
        assert(cell, .exists)
        let topCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottomCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 3))
        topCoordinate.press(forDuration: 0, thenDragTo: bottomCoordinate)
        return self
    }

    @discardableResult
    func checkTitle(contains title: String) -> Self {
        return assert(app.navigationBars[title], .isHittable)
    }
    
    @discardableResult
    func takeScreenshot(named name: String, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        snapshot(name, timeWaitingForIdle: timeout)
        return self
    }

    @discardableResult
    func closeErrorAlert() -> Self {
        let alert = app.alerts["Error"]
        assert(alert, .exists)
        return tap(alert.buttons["Ok"])
    }
}
