@testable import NetworkKit
import XCTest

final class RequestTest: XCTestCase {
    private var sut: Request!

    func testFetchImageRequestSuccessfully() {
        let url = "https://static01.nyt.com/images/2018/08/27/opinion/27gordon/27gordon-thumbLarge.jpg"
        sut = .fetchImage(url)

        XCTAssertEqual(sut.url, url)
        XCTAssertEqual(sut.method, .get)

        switch sut.parameters {
        case .none:
            break
        default:
            XCTFail("Expected no parameters")
        }
    }

    func testFetchTopStoriesRequestSuccessfully() {
        sut = .fetchTopStories

        XCTAssertEqual(sut.url, "https://api.nytimes.com/svc/topstories/v2/home.json")
        XCTAssertEqual(sut.method, .get)

        switch sut.parameters {
        case let .url(url):
            XCTAssertEqual(url, ["api-key": "de87f25eb97b4f038d8360e0de22e1dd"])
        default:
            XCTFail("Expected url parameters")
        }
    }
}
