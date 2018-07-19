import XCTest
@testable import SwiftKotlination

final class TopStoriesViewTest: XCTestCase {
    
    var sut: TopStoriesView!

    func testSubviews() {
        sut = TopStoriesView(frame: CGRect())
        
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
        XCTAssertEqual(sut.backgroundColor, .black)
        XCTAssertEqual(sut.tableView.backgroundColor, .black)
    }
}
