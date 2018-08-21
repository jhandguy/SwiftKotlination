import XCTest
@testable import SwiftKotlination

final class TopStoriesViewControllerTest: XCTestCase {
    
    var sut: TopStoriesViewController!
    
    func testTopStoriesViewControllerViewDidLoad() {
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: TopStoriesRepositoryMock(result: .failure(.unknown)))
        
        _ = sut.view
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Top Stories")
        XCTAssertEqual(sut.view, sut.topStoriesView)
        XCTAssertEqual(sut.view.backgroundColor, .black)
    }
    
    func testTopStoriesViewControllerViewWillAppear() {
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
}
