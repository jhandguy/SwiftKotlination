import XCTest
@testable import SwiftKotlination

final class TopStoriesTableViewCellTest: XCTestCase {

    var sut: TopStoriesTableViewCell!

    private lazy var contentStackView: UIStackView = {
        guard let contentStackView = sut.contentView.subviews[0] as? UIStackView else {
            XCTFail("Expected root subview to be a UIStackView")
            return UIStackView()
        }

        return contentStackView
    }()

    private lazy var descriptionStackView: UIStackView = {
        guard let descriptionStackView = contentStackView.arrangedSubviews[1] as? UIStackView else {
            XCTFail("Expected root subview of \(contentStackView) to be a UIStackView")
            return UIStackView()
        }

        return descriptionStackView
    }()

    override func setUp() {
        super.setUp()

        sut = TopStoriesTableViewCell(style: .default, reuseIdentifier: TopStoriesTableViewCell.identifier)
    }

    func testTopStoriesTableViewCellSuccessfully() {
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.backgroundColor, .white)

        XCTAssertTrue(sut.constraints.isEmpty)
    }

    func testTopStoriesContentViewSuccessfully() {
        XCTAssertEqual(sut.contentView.subviews.count, 1)

        XCTAssertTrue(sut.contentView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.contentView.constraints.count, 4)
        for (index, constraint) in sut.contentView.constraints.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(constraint.firstAnchor, contentStackView.topAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.contentView.topAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            case 1:
                XCTAssertEqual(constraint.firstAnchor, contentStackView.bottomAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.contentView.bottomAnchor)
                XCTAssertEqual(constraint.constant, -8)
                XCTAssertTrue(constraint.isActive)
            case 2:
                XCTAssertEqual(constraint.firstAnchor, contentStackView.leadingAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.contentView.leadingAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            case 3:
                XCTAssertEqual(constraint.firstAnchor, contentStackView.trailingAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.contentView.trailingAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            default:
                XCTFail("Unexpected constraint \(constraint)")
            }
        }
    }

    func testTopStoriesContentStackViewSuccessfully() {
        XCTAssertEqual(contentStackView.arrangedSubviews.count, 2)

        XCTAssertEqual(contentStackView.arrangedSubviews[0], sut.multimediaImageView)
        XCTAssertEqual(contentStackView.arrangedSubviews[1], descriptionStackView)

        XCTAssertFalse(contentStackView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(contentStackView.constraints.isEmpty)
        XCTAssertEqual(contentStackView.axis, .horizontal)
        XCTAssertEqual(contentStackView.alignment, .fill)
        XCTAssertEqual(contentStackView.distribution, .fill)
        XCTAssertEqual(contentStackView.spacing, 8)
    }

    func testTopStoriesDescriptionStackViewSuccessfully() {
        XCTAssertEqual(descriptionStackView.arrangedSubviews.count, 2)

        XCTAssertEqual(descriptionStackView.arrangedSubviews[0], sut.titleLabel)
        XCTAssertEqual(descriptionStackView.arrangedSubviews[1], sut.bylineLabel)

        XCTAssertFalse(descriptionStackView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(descriptionStackView.constraints.isEmpty)
        XCTAssertEqual(descriptionStackView.axis, .vertical)
        XCTAssertEqual(descriptionStackView.alignment, .fill)
        XCTAssertEqual(descriptionStackView.distribution, .fillProportionally)
        XCTAssertEqual(descriptionStackView.spacing, 0)
    }

    func testTopStoriesMultimediaImageViewSuccessfully() {
        XCTAssertFalse(sut.multimediaImageView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.multimediaImageView.constraints.count, 1)
        for (index, constraint) in sut.multimediaImageView.constraints.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(constraint.firstAnchor, sut.multimediaImageView.heightAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.multimediaImageView.widthAnchor)
                XCTAssertEqual(constraint.multiplier, 1)
                XCTAssertTrue(constraint.isActive)
            default:
                XCTFail("Unexpected constraint \(constraint)")
            }
        }
        XCTAssertTrue(sut.multimediaImageView.isHidden)
    }

    func testTopStoriesTitleLabelSuccessfully() {
        XCTAssertFalse(sut.titleLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.titleLabel.constraints.isEmpty)
        XCTAssertEqual(sut.titleLabel.font, UIFont.preferredFont(forTextStyle: .headline))
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
    }

    func testTopStoriesBylineLabelSuccessfully() {
        XCTAssertFalse(sut.bylineLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.bylineLabel.constraints.isEmpty)
        XCTAssertEqual(sut.bylineLabel.font, UIFont.preferredFont(forTextStyle: .footnote))
        XCTAssertEqual(sut.bylineLabel.numberOfLines, 0)
    }
}
