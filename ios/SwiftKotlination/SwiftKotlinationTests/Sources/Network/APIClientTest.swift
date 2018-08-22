import XCTest
@testable import SwiftKotlination

final class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    
    func testSubscribeToRequest() {
        let session = URLSessionMock(
            results: [
                .success("{}")
            ]
        )
        sut = APIClient(session: session)
        
        let notifyClosure = expectation(description: "Closure is notified")
        sut.subscribe(to: .fetchTopStories) { result in
            switch result {
            case .success:
                notifyClosure.fulfill()
            case .failure:
                break
            }
        }
        wait(for: [notifyClosure], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
    
    func testExecuteRequest() {
        let session = URLSessionMock(
            results: [
                .success("{}"),
                .success("{}")
            ]
        )
        sut = APIClient(session: session)
        
        let notifyClosure = expectation(description: "Closure is notified")
        notifyClosure.expectedFulfillmentCount = 2
        sut.subscribe(to: .fetchTopStories) { result in
            switch result {
            case .success:
                notifyClosure.fulfill()
            case .failure:
                break
            }
        }
        sut.execute(request: .fetchTopStories)
        wait(for: [notifyClosure], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
    
    func testSubscribeToRequestSeveralTimesAndExecute() {
        let session = URLSessionMock(
            results: [
                .success("{}"),
                .failure(.unknown),
                .success("{}")
            ]
        )
        sut = APIClient(session: session)
        
        let notifyClosure = expectation(description: "Closure is notified")
        notifyClosure.expectedFulfillmentCount = 4
        sut.subscribe(to: .fetchTopStories) { result in
            switch result {
            case .success:
                notifyClosure.fulfill()
            case .failure:
                break
            }
        }
        sut.subscribe(to: .fetchTopStories) { result in
            switch result {
            case .success:
                notifyClosure.fulfill()
            case .failure:
                notifyClosure.fulfill()
            }
        }
        sut.execute(request: .fetchTopStories)
        wait(for: [notifyClosure], timeout: 1)
        session.dataTasks.forEach { XCTAssertTrue($0.isResumed)}
    }
}
