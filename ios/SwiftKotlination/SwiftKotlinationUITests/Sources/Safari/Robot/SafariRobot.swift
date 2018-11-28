import XCTest

final class SafariRobot: Robot {

    // MARK: - Internal Methods
    
    @discardableResult
    func checkSafariURL(_ predicate: Predicate) -> Self {
        return assert(app.buttons["URL"], predicate)
    }

    @discardableResult
    func closeSafari() -> Self {
        return tap(app.buttons["Done"])
    }
}
