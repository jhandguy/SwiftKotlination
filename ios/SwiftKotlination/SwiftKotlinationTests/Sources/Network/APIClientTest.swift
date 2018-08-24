import XCTest
@testable import SwiftKotlination

final class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    
    func testSubscribeToRequest() {
        let session = URLSessionMock(
            results: [
                (json: "{}", error: nil)
            ]
        )
        sut = APIClient(session: session)
        
        let didObserve = expectation(description: "Expected observer to be notified")
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success:
                didObserve.fulfill()
            case .failure:
                break
            }
        }
        wait(for: [didObserve], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
    
    func testExecuteRequest() {
        let session = URLSessionMock(
            results: [
                (json: "{}", error: nil),
                (json: "{}", error: nil)
            ]
        )
        sut = APIClient(session: session)
        
        let didObserve = expectation(description: "Expected observer to be notified")
        didObserve.expectedFulfillmentCount = 2
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success:
                didObserve.fulfill()
            case .failure:
                break
            }
        }
        sut.execute(.fetchTopStories)
        wait(for: [didObserve], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
    
    func testSubscribeToRequestSeveralTimesAndExecute() {
        let session = URLSessionMock(
            results: [
                (json: "{}", error: nil),
                (json: nil, error: .invalidResponse),
                (json: "{}", error: nil)
            ]
        )
        sut = APIClient(session: session)
        
        let didObserve = expectation(description: "Expected observer to be notified")
        didObserve.expectedFulfillmentCount = 4
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success:
                didObserve.fulfill()
            case .failure:
                break
            }
        }
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success:
                didObserve.fulfill()
            case .failure:
                didObserve.fulfill()
            }
        }
        sut.execute(.fetchTopStories)
        wait(for: [didObserve], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
}
