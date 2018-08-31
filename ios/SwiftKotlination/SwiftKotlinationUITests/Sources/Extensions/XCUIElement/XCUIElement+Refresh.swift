import XCTest

extension XCUIElement {
    func refresh() {
        let startCoordinate = cells.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finishCoordinate = cells.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 2))
        startCoordinate.press(forDuration: 0, thenDragTo: finishCoordinate)
    }
}
