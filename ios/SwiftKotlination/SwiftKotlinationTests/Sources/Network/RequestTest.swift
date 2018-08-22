import XCTest
@testable import SwiftKotlination

final class RequestTest: XCTestCase {
    
    var sut: Request!
    
    func testFetchTopStoriesRequest() {
        sut = .fetchTopStories
        
        XCTAssertEqual(sut.url, "https://api.nytimes.com/svc/topstories/v2/home.json")
        XCTAssertEqual(sut.method, .get)
        
        switch sut.parameters {
        case .url(let url):
            XCTAssertEqual(url, ["api-key": "de87f25eb97b4f038d8360e0de22e1dd"])
        default:
            XCTFail("Expected url parameters")
        }
    }
}
