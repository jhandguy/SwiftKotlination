import XCTest
@testable import SwiftKotlination

final class TopStoriesViewTest: XCTestCase {
    
    var sut: TopStoriesView!

    func testSubviews() {
        sut = TopStoriesView(frame: CGRect())
        
        _ = sut.tableView
        XCTAssertTrue(sut.subviews.contains(sut.tableView))
        XCTAssertEqual(sut.tableView.backgroundColor, .black)
    }
}
