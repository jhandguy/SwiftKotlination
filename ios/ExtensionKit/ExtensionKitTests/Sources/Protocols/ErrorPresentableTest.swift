@testable import ExtensionKit
import XCTest

final class ErrorPresentableTest: XCTestCase {
    private var sut: ViewController!

    func test() throws {
        sut = ViewController()

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut

        sut.viewDidLoad()

        let error: Error = .somethingWentWrong
        sut.present(error, animated: false)

        let alertController = try XCTUnwrap(sut.presentedViewController as? UIAlertController)
        XCTAssertEqual(alertController.title, "Error")
        XCTAssertEqual(alertController.message, error.description)
        XCTAssertEqual(alertController.actions.count, 1)
        XCTAssertEqual(alertController.actions.first?.title, "Ok")
        XCTAssertEqual(alertController.actions.first?.style, .default)
    }
}

private final class ViewController: UIViewController, ErrorPresentable {}

private enum Error: ErrorStringConvertible {
    case somethingWentWrong

    var description: String {
        switch self {
        case .somethingWentWrong:
            return "Something went wrong."
        }
    }
}
