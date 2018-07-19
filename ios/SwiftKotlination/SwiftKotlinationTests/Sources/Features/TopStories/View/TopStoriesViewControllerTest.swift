import XCTest
@testable import SwiftKotlination

final class TopStoriesViewControllerTest: XCTestCase {
    
    var sut: TopStoriesViewController!
    
    func testTopStoriesViewControllerViewDidLoad() {
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: TopStoriesRepositoryMock())
        
        _ = sut.view
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.title, "Top Stories")
        XCTAssertEqual(sut.view, sut.topStoriesView)
    }
    
    func testTopStoriesViewControllerViewWillAppear() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url")
        sut = TopStoriesViewController()
        sut.viewModel = TopStoriesViewModel(repository: TopStoriesRepositoryMock(storiesStub: .success([story])))
        
        _ = sut.view
        sut.viewWillAppear(true)
        
        XCTAssertEqual(sut.topStoriesView.tableView.visibleCells.count, 1)
        
        guard let cell = sut.topStoriesView.tableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? TopStoriesTableViewCell else {
            XCTFail("Cell should be of type \(TopStoriesTableViewCell.self)")
            return
        }
        
        XCTAssertEqual(cell.titleLabel.text, story.title)
        XCTAssertEqual(cell.bylineLabel.text, story.byline)
    }
}
