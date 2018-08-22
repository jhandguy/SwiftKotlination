import XCTest
@testable import SwiftKotlination

final class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    
    func testSubscribeToRequest() {
        let session = URLSessionMock(responses: [
            (json: "{}", error: nil, dataTask: URLSessionDataTaskMock())
        ])
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
        let session = URLSessionMock(responses: [
            (json: "{}", error: nil, dataTask: URLSessionDataTaskMock()),
            (json: "{}", error: nil, dataTask: URLSessionDataTaskMock())
        ])
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
}
