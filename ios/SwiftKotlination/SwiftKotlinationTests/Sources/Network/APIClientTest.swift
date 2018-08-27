import XCTest
@testable import SwiftKotlination

final class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    
    func testObserveRequestSuccessfully() {
        let session = URLSessionMock(
            responses: [
                Response(File("top_stories", .json))
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
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
    
    func testExecuteRequestSuccessfully() {
        let session = URLSessionMock(
            responses: [
                Response(File("top_stories", .json)),
                Response(File("top_stories", .json))
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
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
    
    func testObserveRequestSeveralTimesAndExecuteSuccessfully() {
        let session = URLSessionMock(
            responses: [
                Response(File("top_stories", .json)),
                Response(error: .invalidResponse),
                Response(File("top_stories", .json))
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
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
}
