import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {
    
    var sut: StoryViewController!
    
    override func setUp() {
        super.setUp()
        
        guard let viewController = StoryViewController.storyBoardInstance else {
            XCTFail("Expected view controller story board instantiation to succeed")
            return
        }
        sut = viewController
        
        _ = sut.view
    }
    
    func testStoryViewControllerViewWillAppearSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = StoryRepositoryMock(result: .success(story))
        sut.viewModel = StoryViewModel(repository: repository)
        
        sut.viewWillAppear(false)
        
        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.titleLabel.text, story.title)
        XCTAssertEqual(sut.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.bylineLabel.text, story.byline)
    }
    
    func testStoryViewControllerViewWillAppearFailure() {
        let repository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = StoryViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewWillAppear(false)
        
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    func testStoryViewControllerOpenUrl() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = StoryRepositoryMock(result: .success(story))
        sut.viewModel = StoryViewModel(repository: repository)
        
        sut.viewWillAppear(false)
        
        let coordinator = CoordinatorMock(expectedMethods: [.openUrl])
        sut.coordinator = coordinator
        sut.urlButton.sendActions(for: .touchUpInside)
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
