import XCTest
@testable import SwiftKotlination

final class AppDelegateTest: XCTestCase {
    
    var sut: AppDelegate!
    
    func testAppDelegateStartsCoordinator() {
        let coordinator = CoordinatorMock(expectedMethods: [.start])
        sut = AppDelegate()
        sut.coordinator = coordinator
        
        _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: [:])
        
        wait(for: [coordinator.expectation], timeout: 1)
    }
    
}
