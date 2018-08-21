import XCTest
@testable import SwiftKotlination

final class TopStoriesTableViewCellTest: XCTestCase {
    
    var sut: TopStoriesTableViewCell!
    
    func testTopStoriesTableViewCell() {
        sut = TopStoriesTableViewCell(style: .default, reuseIdentifier: TopStoriesTableViewCell.identifier)
        
        _ = sut.titleLabel
        _ = sut.bylineLabel
        _ = sut.seeButton
        
        XCTAssertTrue(sut.contentView.subviews.contains(sut.titleLabel))
        XCTAssertTrue(sut.contentView.subviews.contains(sut.bylineLabel))
        XCTAssertTrue(sut.contentView.subviews.contains(sut.seeButton))
        
        XCTAssertEqual(sut.titleLabel.textColor, .white)
        XCTAssertEqual(sut.bylineLabel.textColor, .white)
        XCTAssertEqual(sut.seeButton.titleColor(for: .normal), .red)
        
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
        XCTAssertEqual(sut.bylineLabel.numberOfLines, 1)
        
        XCTAssertEqual(sut.titleLabel.font, UIFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(sut.bylineLabel.font, UIFont.preferredFont(forTextStyle: .subheadline))
        
        XCTAssertEqual(sut.seeButton.title(for: .normal), "see".uppercased())
    }
    
}
