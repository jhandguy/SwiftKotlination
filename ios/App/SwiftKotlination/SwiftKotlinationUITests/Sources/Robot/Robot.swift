import ExtensionKit
import NetworkKit
import TestKit
import XCTest

class Robot {
    private static let defaultTimeout: Double = 30

    var app: XCUIApplication

    lazy var navigationBar = app.navigationBars.firstMatch
    lazy var navigationBarButton = navigationBar.buttons.firstMatch
    lazy var navigationBarTitle = navigationBar.staticTexts.firstMatch
    lazy var alert = app.alerts.firstMatch
    lazy var alertButton = alert.buttons.firstMatch

    init(_ app: XCUIApplication) {
        self.app = app
        setupSnapshot(app)
    }

    @discardableResult
    func start(
        _ coordinatorStub: CoordinatorStub,
        with sessionMock: URLSessionMock = URLSessionMock(),
        and animationStub: AnimationStub = .disableAnimations,
        timeout: TimeInterval = Robot.defaultTimeout
    ) -> Self {
        app.launchEnvironment[CoordinatorStub.tag] = coordinatorStub.json
        app.launchEnvironment[URLSessionMock.tag] = sessionMock.json
        app.launchEnvironment[AnimationStub.tag] = animationStub.json

        app.launch()

        assert(app, [.exists], timeout: timeout)

        return self
    }

    @discardableResult
    func finish(timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        app.terminate()
        assert(app, [.doesNotExist], timeout: timeout)

        return self
    }

    @discardableResult
    func tap(_ element: XCUIElement, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        assert(element, [.isHittable], timeout: timeout)
        element.tap()

        return self
    }

    @discardableResult
    func assert(_ element: XCUIElement, _ predicates: [Predicate], timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: predicates.map { $0.format }.joined(separator: " AND ")), object: element)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed else {
            XCTFail("[\(self)] Element \(element.description) did not fulfill expectation: \(predicates.map { $0.format })")
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
        assert(cell, [.isHittable], timeout: timeout)

        let topCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottomCoordinate = cell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 3))
        topCoordinate.press(forDuration: 0, thenDragTo: bottomCoordinate)

        return self
    }

    @discardableResult
    func checkTitle(contains title: String, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        assert(navigationBar, [.isHittable], timeout: timeout)
        assert(navigationBarTitle, [.contains(title)], timeout: timeout)

        return self
    }

    @discardableResult
    func takeScreenshot(named name: String, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        snapshot(name, timeWaitingForIdle: timeout)

        return self
    }

    @discardableResult
    func checkAlert(contains error: ErrorStringConvertible, timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        let title = alert.staticTexts.element(boundBy: 0)
        let description = alert.staticTexts.element(boundBy: 1)
        assert(title, [.contains("Error")], timeout: timeout)
        assert(description, [.contains(error.description)], timeout: timeout)

        return self
    }

    @discardableResult
    func closeAlert(timeout _: TimeInterval = Robot.defaultTimeout) -> Self {
        assert(alert, [.exists])
        tap(alertButton)
        assert(alert, [.doesNotExist])

        return self
    }

    @discardableResult
    func back(timeout: TimeInterval = Robot.defaultTimeout) -> Self {
        tap(navigationBarButton, timeout: timeout)

        return self
    }
}
