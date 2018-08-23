import XCTest
@testable import SwiftKotlination

final class NetworkErrorTest: XCTestCase {
    
    var sut: NetworkError!
    
    func testInvalidResponse() {
        sut = .invalidResponse
        XCTAssertEqual(sut.description, "Invalid response, please try again later.")
    }
}
