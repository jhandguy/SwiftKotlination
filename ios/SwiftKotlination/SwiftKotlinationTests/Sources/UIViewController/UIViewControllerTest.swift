import XCTest
@testable import SwiftKotlination

final class UIViewControllerTest: XCTestCase {

    var sut: UIViewController!

    override func setUp() {
        super.setUp()

        sut = UIViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewDidLoad()
    }

    func testViewControllerPresentsAlertControllerSuccessfully() {
        let error: NetworkError = .invalidResponse
        sut.presentAlertController(with: error, animated: false)

        guard let alertController = sut.presentedViewController as? UIAlertController else {
            XCTFail("Expected UIAlertController to be presented")
            return
        }

        XCTAssertEqual(alertController.title, "Error")
        XCTAssertEqual(alertController.message, error.description)
        XCTAssertEqual(alertController.actions.count, 1)
        XCTAssertEqual(alertController.actions.first?.title, "Ok")
        XCTAssertEqual(alertController.actions.first?.style, .default)
    }
}
