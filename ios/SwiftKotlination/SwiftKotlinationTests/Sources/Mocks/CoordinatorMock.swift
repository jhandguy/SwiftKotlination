import XCTest
@testable import SwiftKotlination

final class CoordinatorMock: CoordinatorProtocol {
    var expectation: XCTestExpectation
    var expectedMethods: [ExpectedMethod]
    
    init(expectedMethods: [ExpectedMethod] = []) {
        self.expectedMethods = expectedMethods
        expectation = XCTestExpectation(description: "Expected to call methods: \(expectedMethods.map { $0.rawValue }.joined(separator: ", "))")
        expectation.expectedFulfillmentCount = expectedMethods.count
    }
    
    enum ExpectedMethod: String {
        case start
        case openStory
    }
    
    func start() {
        if expectedMethods.contains(.start) {
            expectation.fulfill()
        }
    }
    
    func open(_ story: Story) {
        if expectedMethods.contains(.openStory) {
            expectation.fulfill()
        }
    }
    
}
