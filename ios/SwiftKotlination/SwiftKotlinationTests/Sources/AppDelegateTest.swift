import XCTest
@testable import SwiftKotlination

final class AppDelegateTest: XCTestCase {
    
    var sut: AppDelegate!
    
    func testCoordinatorStartsOnLaunch() {
        let mock = CoordinatorMock(expectedMethods: [.start])
        sut = AppDelegate()
        sut.coordinator = mock
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        wait(for: [mock.expectation], timeout: 0)
    }
}
