import XCTest
@testable import SwiftKotlination

final class AppDelegateTest: XCTestCase {

    var sut: AppDelegate!

    override func setUp() {
        super.setUp()
        sut = AppDelegate()
    }

    func testAppDelegateStartsCoordinatorSuccessfully() {
        let factory = CoordinatorFactoryMock(coordinator: CoordinatorMock())
        sut.factory = factory

        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])

        XCTAssertTrue(factory.coordinator.isStarted)
    }

}
