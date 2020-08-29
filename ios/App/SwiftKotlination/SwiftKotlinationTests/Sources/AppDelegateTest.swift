@testable import SwiftKotlination
import XCTest

final class AppDelegateTest: XCTestCase {
    private var sut: AppDelegate!

    override func setUp() {
        super.setUp()

        sut = AppDelegate()
    }

    func testAppDelegateStartsCoordinatorSuccessfully() {
        let coordinator = CoordinatorMock()
        sut.coordinator = coordinator

        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertTrue(coordinator.isStarted)
    }
}
