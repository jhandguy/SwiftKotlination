@testable import StoryKit
import XCTest

final class StoryViewTest: XCTestCase {
    private var sut: StoryView!

    private lazy var scrollView: UIScrollView = {
        guard let scrollView = sut.subviews[0] as? UIScrollView else {
            XCTFail("Expected root subview to be a UIScrollView")
            return UIScrollView()
        }

        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        guard let stackView = scrollView.subviews[0] as? UIStackView else {
            XCTFail("Expected root subview of \(scrollView) to be a UIStackView")
            return UIStackView()
        }

        return stackView
    }()

    override func setUp() {
        super.setUp()

        sut = StoryView()
    }

    func testStoryViewSuccessfully() {
        XCTAssertEqual(sut.subviews.count, 1)
        XCTAssertEqual(sut.backgroundColor, .white)

        XCTAssertEqual(sut.constraints.count, 8)
    }

    func testStoryViewScrollViewSuccessfully() {
        XCTAssertEqual(scrollView.subviews.count, 1)

        XCTAssertFalse(scrollView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(scrollView.constraints.count, 5)
        for (index, constraint) in scrollView.constraints.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(constraint.firstAnchor, stackView.topAnchor)
                XCTAssertEqual(constraint.secondAnchor, scrollView.topAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            case 1:
                XCTAssertEqual(constraint.firstAnchor, stackView.bottomAnchor)
                XCTAssertEqual(constraint.secondAnchor, scrollView.bottomAnchor)
                XCTAssertEqual(constraint.constant, -8)
                XCTAssertTrue(constraint.isActive)
            case 2:
                XCTAssertEqual(constraint.firstAnchor, stackView.leadingAnchor)
                XCTAssertEqual(constraint.secondAnchor, scrollView.leadingAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            case 3:
                XCTAssertEqual(constraint.firstAnchor, stackView.trailingAnchor)
                XCTAssertEqual(constraint.secondAnchor, scrollView.trailingAnchor)
                XCTAssertEqual(constraint.constant, 8)
                XCTAssertTrue(constraint.isActive)
            case 4:
                XCTAssertEqual(constraint.firstAnchor, stackView.widthAnchor)
                XCTAssertEqual(constraint.secondAnchor, scrollView.widthAnchor)
                XCTAssertEqual(constraint.constant, -16)
                XCTAssertTrue(constraint.isActive)
            default:
                XCTFail("Unexpected constraint \(constraint)")
            }
        }
        XCTAssertTrue(scrollView.showsVerticalScrollIndicator)
    }

    func testStoryViewStackViewSuccesfully() {
        XCTAssertEqual(stackView.arrangedSubviews.count, 5)

        XCTAssertEqual(stackView.arrangedSubviews[0], sut.multimediaImageView)
        XCTAssertEqual(stackView.arrangedSubviews[1], sut.titleLabel)
        XCTAssertEqual(stackView.arrangedSubviews[2], sut.abstractLabel)
        XCTAssertEqual(stackView.arrangedSubviews[3], sut.bylineLabel)
        XCTAssertEqual(stackView.arrangedSubviews[4], sut.urlButton)

        XCTAssertFalse(stackView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(stackView.constraints.isEmpty)
        XCTAssertEqual(stackView.axis, .vertical)
        XCTAssertEqual(stackView.alignment, .fill)
        XCTAssertEqual(stackView.distribution, .fill)
        XCTAssertEqual(stackView.spacing, 28)
    }

    func testStoryViewMutlimediaImageView() {
        XCTAssertFalse(sut.multimediaImageView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.multimediaImageView.constraints.count, 1)
        for (index, constraint) in sut.multimediaImageView.constraints.enumerated() {
            switch index {
            case 0:
                XCTAssertEqual(constraint.firstAnchor, sut.multimediaImageView.heightAnchor)
                XCTAssertEqual(constraint.secondAnchor, sut.multimediaImageView.widthAnchor)
                XCTAssertEqual(constraint.multiplier, 0.6666666865348816)
                XCTAssertTrue(constraint.isActive)
            default:
                XCTFail("Unexpected constraint \(constraint)")
            }
        }
        XCTAssertTrue(sut.multimediaImageView.isHidden)
    }

    func testStoryViewTitleLabel() {
        XCTAssertFalse(sut.titleLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.titleLabel.constraints.isEmpty)
        XCTAssertEqual(sut.titleLabel.textAlignment, .center)
        XCTAssertEqual(sut.titleLabel.font, UIFont.preferredFont(forTextStyle: .title1))
        XCTAssertEqual(sut.titleLabel.numberOfLines, 0)
    }

    func testStoryViewAbstractLabel() {
        XCTAssertFalse(sut.abstractLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.abstractLabel.constraints.isEmpty)
        XCTAssertEqual(sut.abstractLabel.textAlignment, .justified)
        XCTAssertEqual(sut.abstractLabel.font, UIFont.preferredFont(forTextStyle: .body))
        XCTAssertEqual(sut.abstractLabel.numberOfLines, 0)
    }

    func testStoryViewBylineLabel() {
        XCTAssertFalse(sut.bylineLabel.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.bylineLabel.constraints.isEmpty)
        XCTAssertEqual(sut.bylineLabel.textAlignment, .justified)
        XCTAssertEqual(sut.bylineLabel.font, UIFont.preferredFont(forTextStyle: .footnote))
        XCTAssertEqual(sut.bylineLabel.numberOfLines, 0)
    }

    func testStoryViewUrlButton() {
        XCTAssertFalse(sut.urlButton.translatesAutoresizingMaskIntoConstraints)
        XCTAssertTrue(sut.urlButton.constraints.isEmpty)
        XCTAssertEqual(sut.urlButton.titleColor(for: .normal), sut.tintColor)
        XCTAssertEqual(sut.urlButton.contentHorizontalAlignment, .right)
        XCTAssertEqual(sut.urlButton.title(for: .normal), "Read more...")
    }
}
