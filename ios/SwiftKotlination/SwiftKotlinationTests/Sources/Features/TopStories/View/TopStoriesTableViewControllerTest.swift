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
    
    func testTopStoriesTableViewControllerFetchesTopStoriesSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story]))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let topStoriesViewModel = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        sut.viewModel = topStoriesViewModel
        
        sut.viewDidLoad()
        sut.viewWillAppear(false)
        
        let tableViewIsNotEmpty = expectation(description: "Expected table view to not be empty")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            tableViewIsNotEmpty.fulfill()
        }
        wait(for: [tableViewIsNotEmpty], timeout: 1)
        
        topStoriesRepository.result = .success([])
        topStoriesViewModel.reload()
        
        let tableViewIsEmpty = expectation(description: "Expected table view to be empty")
        DispatchQueue.main.async {
            XCTAssertTrue(self.sut.tableView.visibleCells.isEmpty)
            tableViewIsEmpty.fulfill()
        }
        wait(for: [tableViewIsEmpty], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerFetchesTopStoriesUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story]))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let topStoriesViewModel = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        sut.viewModel = topStoriesViewModel
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewDidLoad()
        sut.viewWillAppear(false)
        
        let tableViewIsNotEmpty = expectation(description: "Expected table view to not be empty")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            tableViewIsNotEmpty.fulfill()
        }
        wait(for: [tableViewIsNotEmpty], timeout: 1)
        
        topStoriesRepository.result = .failure(NetworkError.invalidResponse)
        topStoriesViewModel.reload()
        
        let alertControllerIsPresented = expectation(description: "Expected alert controller to be presented")
        DispatchQueue.main.async {
            XCTAssertFalse(self.sut.tableView.visibleCells.isEmpty)
            XCTAssertTrue(self.sut.presentedViewController is UIAlertController)
            alertControllerIsPresented.fulfill()
        }
        wait(for: [alertControllerIsPresented], timeout: 1)
    }
    
    func testTopStoriesTableViewControllerOpensStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let topStoriesRepository = TopStoriesRepositoryMock(result: .success([story]))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let coordinator = CoordinatorMock(expectedMethods: [.openStory])
        sut = TopStoriesTableViewController()
        sut.viewModel = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        sut.coordinator = coordinator
        
        sut.viewDidLoad()
        
        DispatchQueue.main.async {
            self.sut.tableView(self.sut.tableView, didSelectRowAt: IndexPath(item: 0, section: 0))
        }
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
