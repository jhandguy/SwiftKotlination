import XCTest
@testable import SwiftKotlination

final class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    
    func testObserveRequestSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file)
            ]
        )
        sut = APIClient(session: session)
        
        var times = 0
        
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, file.data)
            case .failure:
                XCTFail("Observe on request should succeed")
            }
            times += 1
        }
        XCTAssertEqual(times, 1)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
    
    func testExecuteRequestSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file),
                Response(file)
            ]
        )
        sut = APIClient(session: session)
        
        var times = 0
        
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, file.data)
            case .failure:
                XCTFail("Execute request should succeed")
            }
            times += 1
        }
        
        sut.execute(.fetchTopStories)
        
        XCTAssertEqual(times, 2)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
    
    func testObserveRequestSeveralTimesAndExecuteSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file),
                Response(error: .invalidResponse),
                Response(file)
            ]
        )
        sut = APIClient(session: session)
        
        var times = 0
        
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, file.data)
            case .failure:
                break
            }
            times += 1
        }
        
        sut.observe(.fetchTopStories) { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, file.data)
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .invalidResponse)
            }
            times += 1
        }
        
        sut.execute(.fetchTopStories)
        
        XCTAssertEqual(times, 4)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }
    }
}
