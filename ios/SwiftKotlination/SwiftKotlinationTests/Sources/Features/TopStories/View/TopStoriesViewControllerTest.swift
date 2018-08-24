import XCTest
@testable import SwiftKotlination

final class TopStoriesViewControllerTest: XCTestCase {
    
    var sut: TopStoriesViewController!
    
    func testTopStoriesViewControllerViewDidLoadSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertEqual(self.sut.title, "Top Stories")
            XCTAssertEqual(self.sut.view.backgroundColor, .black)
            XCTAssertEqual(self.sut.view, self.sut.topStoriesView)
            
            XCTAssertEqual(self.sut.topStoriesView.tableView.visibleCells.count, 1)
            
            guard let cell = self.sut.topStoriesView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
                XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
                return
            }
            
            XCTAssertEqual(cell.selectedBackgroundView?.backgroundColor, .darkGray)
            XCTAssertEqual(cell.contentView.backgroundColor, .black)
            XCTAssertEqual(cell.titleLabel.text, story.title)
            XCTAssertEqual(cell.bylineLabel.text, story.byline)
            
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
    }
    
    func testTopStoriesViewControllerViewDidLoadFailure() {
        let repository = TopStoriesRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.topStoriesView.tableView.visibleCells.isEmpty)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
    }
    
    func testTopStoriesViewControllerViewWillAppearSuccess() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.topStoriesView.tableView.visibleCells.isEmpty)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        repository.result = .success([])
        sut.viewWillAppear(true)
        
        let viewWillAppear = expectation(description: "Expected view to appear")
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.topStoriesView.tableView.visibleCells.isEmpty)
            viewWillAppear.fulfill()
        }
        wait(for: [viewWillAppear], timeout: 1)
    }
    
    func testTopStoriesViewControllerViewWillAppearFailure() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewDidLoad()
        
        let viewDidLoad = expectation(description: "Expected view to be loaded")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.topStoriesView.tableView.visibleCells.isEmpty)
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        repository.result = .failure(NetworkError.invalidResponse)
        sut.viewWillAppear(true)
        
        let viewWillAppear = expectation(description: "Expected view to appear")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.topStoriesView.tableView.visibleCells.isEmpty)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            viewWillAppear.fulfill()
        }
        wait(for: [viewWillAppear], timeout: 1)
    }
    
    func testTopStoriesViewControllerOpenStory() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        let coordinator = CoordinatorMock(expectedMethods: [.openStory])
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        sut.coordinator = coordinator
        
        sut.viewDidLoad()
        
        DispatchQueue.main.async {
            guard let cell = self.sut.topStoriesView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
                XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
                return
            }
            
            cell.seeButton.sendActions(for: .touchUpInside)
        }
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
