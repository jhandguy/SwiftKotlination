import XCTest

final class SafariUITest: XCTestCase {
    private lazy var app = XCUIApplication()

    func testSafariSuccessfully() {
        let url = "https://url.com"

        SafariRobot(app)
            .start(with: url)
            .checkURL(contains: url)
            .closeSafari()
    }
}
