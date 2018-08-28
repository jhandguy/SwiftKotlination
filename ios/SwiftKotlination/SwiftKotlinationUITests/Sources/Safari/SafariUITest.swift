import XCTest

final class SafariUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()
    
    func testSafariSuccessfully() {
        guard let url = URL(string: "https://url.com") else {
            XCTFail("Invalid URL")
            return
        }
        
        app.launch(.openUrl(url))
        
        XCTAssertTrue(app.buttons["URL"].isHittable)
    }
}
