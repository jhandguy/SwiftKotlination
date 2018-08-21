import XCTest
@testable import SwiftKotlination

final class StoryViewTest: XCTestCase {
    
    var sut: StoryView!

    func testSubviews() {
        sut = StoryView(frame: CGRect())
        
        _ = sut.titleLabel
        _ = sut.abstractLabel
        _ = sut.byLineLabel
        _ = sut.urlButton
        
        XCTAssertTrue(sut.subviews.contains(sut.titleLabel))
        XCTAssertTrue(sut.subviews.contains(sut.abstractLabel))
        XCTAssertTrue(sut.subviews.contains(sut.byLineLabel))
        XCTAssertTrue(sut.subviews.contains(sut.urlButton))
        
        XCTAssertEqual(sut.titleLabel.textAlignment, .center)
        XCTAssertEqual(sut.abstractLabel.textAlignment, .justified)
        XCTAssertEqual(sut.byLineLabel.textAlignment, .justified)
        XCTAssertEqual(sut.urlButton.contentHorizontalAlignment, .center)
        
        XCTAssertEqual(sut.titleLabel.textColor, .white)
        XCTAssertEqual(sut.abstractLabel.textColor, .white)
        XCTAssertEqual(sut.byLineLabel.textColor, .white)
        XCTAssertEqual(sut.urlButton.titleColor(for: .normal), .red)
        
        XCTAssertEqual(sut.titleLabel.font, UIFont.preferredFont(forTextStyle: .title1))
        XCTAssertEqual(sut.abstractLabel.font, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(sut.byLineLabel.font, UIFont.preferredFont(forTextStyle: .footnote))
        
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
        XCTAssertEqual(sut.abstractLabel.numberOfLines, 0)
        XCTAssertEqual(sut.byLineLabel.numberOfLines, 0)
        
        XCTAssertEqual(sut.urlButton.title(for: .normal), "See More")
    }
}
