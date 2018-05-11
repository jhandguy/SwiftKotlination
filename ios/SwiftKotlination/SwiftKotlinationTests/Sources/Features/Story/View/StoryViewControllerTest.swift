import XCTest
import RxSwift
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {
    
    var sut: StoryViewController!
    
    func testStoryViewControllerViewDidLoad() {
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: StoryRepositoryMock())
        
        _ = sut.view
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.view.backgroundColor, .black)
        
        XCTAssertTrue(sut.view.subviews.contains(sut.titleLabel))
        XCTAssertTrue(sut.view.subviews.contains(sut.abstractLabel))
        XCTAssertTrue(sut.view.subviews.contains(sut.byLineLabel))
        XCTAssertTrue(sut.view.subviews.contains(sut.urlButton))
        
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
    
    func testStoryViewControllerViewWillAppear() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: StoryRepositoryMock(storyStub: .success(story)))
        
        _ = sut.view
        sut.viewWillAppear(true)
        
        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.titleLabel.text, story.title)
        XCTAssertEqual(sut.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.byLineLabel.text, story.byline)
    }
}
