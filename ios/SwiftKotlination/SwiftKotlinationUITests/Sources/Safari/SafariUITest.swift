import XCTest

final class SafariUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()

    func testSafariSuccessfully() {
        let url = "https://url.com"

        app.launch(.openUrl(url))

        SafariRobot(app)
            .checkURL(contains: url)
            .closeSafari()
    }
}
