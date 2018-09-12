import XCTest
@testable import SwiftKotlination

final class AppDelegateTest: XCTestCase {

    var sut: AppDelegate!

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
