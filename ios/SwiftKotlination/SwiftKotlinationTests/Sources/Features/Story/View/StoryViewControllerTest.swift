import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {
    
    var sut: StoryViewController!
    
    func testStoryViewControllerViewDidLoad() {
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: StoryRepositoryMock(result: .failure(ResultError.unknown)))
        
        _ = sut.view
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.view, sut.storyView)
        XCTAssertEqual(sut.view.backgroundColor, .black)
    }
    
    func testStoryViewControllerViewWillAppear() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: StoryRepositoryMock(result: .success(story)))
        
        _ = sut.view
        sut.viewWillAppear(true)
        
        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.storyView.titleLabel.text, story.title)
        XCTAssertEqual(sut.storyView.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.storyView.byLineLabel.text, story.byline)
    }
    
    func testStoryViewControllerOpenUrl() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: StoryRepositoryMock(result: .success(story)))
        
        _ = sut.view
        sut.viewWillAppear(true)
        
        let coordinator = CoordinatorMock(expectedMethods: [.openUrl])
        sut.coordinator = coordinator
        sut.storyView.urlButton.sendActions(for: .touchUpInside)
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
