import XCTest
@testable import SwiftKotlination

final class TopStoriesViewControllerTest: XCTestCase {
    
    var sut: TopStoriesViewController!
    
    func testTopStoriesViewControllerViewDidLoad() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: TopStoriesRepositoryMock(result: .success([story])))
        
        _ = sut.view
        
        let viewDidLoad = expectation(description: "viewDidLoad")
        DispatchQueue.main.async {
            self.sut.viewDidLoad()
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        XCTAssertEqual(sut.title, "Top Stories")
        XCTAssertEqual(sut.view.backgroundColor, .black)
        XCTAssertEqual(sut.view, sut.topStoriesView)
        XCTAssertEqual(sut.topStoriesView.tableView.visibleCells.count, 1)
        
        guard let cell = sut.topStoriesView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
            XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
            return
        }
        
        XCTAssertEqual(cell.selectedBackgroundView?.backgroundColor, .darkGray)
        XCTAssertEqual(cell.contentView.backgroundColor, .black)
        XCTAssertEqual(cell.titleLabel.text, story.title)
        XCTAssertEqual(cell.bylineLabel.text, story.byline)
    }
    
    func testTopStoriesViewControllerViewWillAppear() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        let repository = TopStoriesRepositoryMock(result: .success([story]))
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: repository)
        
        _ = sut.view
        
        let viewDidLoad = expectation(description: "viewDidLoad")
        DispatchQueue.main.async {
            self.sut.viewDidLoad()
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        repository.result = .success([])
        
        let viewWillAppear = expectation(description: "viewWillAppear")
        DispatchQueue.main.async {
            self.sut.viewWillAppear(true)
            viewWillAppear.fulfill()
        }
        wait(for: [viewWillAppear], timeout: 1)
        
        XCTAssertTrue(sut.topStoriesView.tableView.visibleCells.isEmpty)
    }
    
    func testTopStoriesViewControllerOpenStory() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: TopStoriesRepositoryMock(result: .success([story])))
        
        _ = sut.view
        
        let viewDidLoad = expectation(description: "viewDidLoad")
        DispatchQueue.main.async {
            self.sut.viewDidLoad()
            viewDidLoad.fulfill()
        }
        wait(for: [viewDidLoad], timeout: 1)
        
        guard let cell = sut.topStoriesView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
            XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
            return
        }
        
        let coordinator = CoordinatorMock(expectedMethods: [.openStory])
        sut.coordinator = coordinator
        cell.seeButton.sendActions(for: .touchUpInside)
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
