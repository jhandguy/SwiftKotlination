import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {
    
    var sut: StoryViewController!
    
    func testStoryViewControllerViewDidLoad() {
        let repository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: repository)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.view, sut.storyView)
        XCTAssertEqual(sut.view.backgroundColor, .black)
    }
    
    func testStoryViewControllerViewWillAppearSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = StoryRepositoryMock(result: .success(story))
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: repository)
        
        sut.viewWillAppear(false)
        
        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.storyView.titleLabel.text, story.title)
        XCTAssertEqual(sut.storyView.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.storyView.byLineLabel.text, story.byline)
    }
    
    func testStoryViewControllerViewWillAppearFailure() {
        let repository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewWillAppear(false)
        
        XCTAssertNil(sut.title)
        XCTAssertNil(sut.storyView.titleLabel.text)
        XCTAssertNil(sut.storyView.abstractLabel.text)
        XCTAssertNil(sut.storyView.byLineLabel.text)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    func testStoryViewControllerOpenUrl() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = StoryRepositoryMock(result: .success(story))
        sut = StoryViewController()
        sut.viewModel = StoryViewModel(repository: repository)
        
        sut.viewWillAppear(false)
        
        let coordinator = CoordinatorMock(expectedMethods: [.openUrl])
        sut.coordinator = coordinator
        sut.storyView.urlButton.sendActions(for: .touchUpInside)
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
