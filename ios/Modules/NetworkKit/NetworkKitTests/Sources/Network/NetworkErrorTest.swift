@testable import NetworkKit
import XCTest

final class NetworkErrorTest: XCTestCase {
    private var sut: NetworkError!

    func testInvalidRequestSuccessfully() {
        sut = .invalidRequest
        XCTAssertEqual(sut.description, "Invalid request, please try again later.")
    }

    func testInvalidResponseSuccessfully() {
        sut = .invalidResponse
        XCTAssertEqual(sut.description, "Invalid response, please try again later.")
    }
}
