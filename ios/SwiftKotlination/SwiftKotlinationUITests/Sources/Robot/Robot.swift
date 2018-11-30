import XCTest

class Robot {

    // MARK: Private Constants

    private static let defaultTimeout: Double = 30
    
    // MARK: - Internal Properties

    var app: XCUIApplication

    // MARK: - Initializer
    
    init(_ app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Internal Methods
    
    @discardableResult
    func tap(_ element: XCUIElement, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        assert(element, .isHittable, timeout: timeout)
        element.tap()
        return self
    }

    @discardableResult
    func assert(_ element: XCUIElement, _ predicate: Predicate, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "\(predicate.rawValue) == true"), object: element)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTFail("[\(self)] Element \(element.description) did not fulfill expectation: \(predicate.rawValue)")
            return self
        }
        return self
    }

    @discardableResult
    func refresh(inside element: XCUIElement, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        guard [.table, .collectionView].contains(element.elementType) else {
            XCTFail("[\(self)] Cannot refresh inside element \(element.description)")
            return self
        }
        let cell = element.cells.firstMatch
        assert(cell, .exists, timeout: timeout)
        let topCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottomCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 3))
        topCoordinate.press(forDuration: 0, thenDragTo: bottomCoordinate)
        return self
    }

    @discardableResult
    func checkTitle(contains title: String, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        return assert(app.navigationBars[title], .isHittable, timeout: timeout)
    }
    
    @discardableResult
    func takeScreenshot(named name: String, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        snapshot(name, timeWaitingForIdle: timeout)
        return self
    }

    @discardableResult
    func closeErrorAlert(timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        let alert = app.alerts["Error"]
        assert(alert, .exists, timeout: timeout)
        return tap(alert.buttons["Ok"])
    }
}
