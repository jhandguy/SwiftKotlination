import XCTest
@testable import SwiftKotlination

final class TopStoriesTableViewControllerTest: XCTestCase {
    
    var sut: TopStoriesTableViewController!
    
    override func setUp() {
        super.setUp()
        
        guard let viewController = TopStoriesTableViewController.storyBoardInstance else {
            XCTFail("Expected view controller story board instantiation to succeed")
            return
        }
        
        sut = viewController
    }
    
    func testTopStoriesTableViewControllerViewDidLoadSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.title, "Top Stories")
            
            XCTAssertEqual(self.sut.tableView.visibleCells.count, 1)
            
            guard let cell = self.sut.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
                XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
                return
            }
            
            XCTAssertEqual(cell.titleLabel.text, story.title)
            XCTAssertEqual(cell.bylineLabel.text, story.byline)
            
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerViewDidLoadFailure() {
        let repository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.tableView.visibleCells.isEmpty)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerViewWillAppearSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        repository.result = .success([])
        sut.viewWillAppear(true)
        
        let viewWillAppear = expectation(description: "Expected view to appear")
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.tableView.visibleCells.isEmpty)
            viewWillAppear.fulfill()
        }
        wait(for: [viewWillAppear], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerViewWillAppearFailure() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesTableViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        repository.result = .failure(NetworkError.invalidResponse)
        sut.viewWillAppear(true)
        
        let viewWillAppear = expectation(description: "Expected view to appear")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            viewWillAppear.fulfill()
        }
        wait(for: [viewWillAppear], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerOpenStory() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        let coordinator = CoordinatorMock(expectedMethods: [.openStory])
        sut = TopStoriesTableViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        sut.coordinator = coordinator
        
        sut.viewDidLoad()
        
        DispatchQueue.main.async {
            self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        }
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
