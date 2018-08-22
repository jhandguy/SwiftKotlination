import XCTest
@testable import SwiftKotlination

final class TopStoriesUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()
    
    func testFeatureTopStories() {
        let topStories = TopStories(
            results: [
                Story(
                    section: "section1",
                    subsection: "subsection1",
                    title: "title1",
                    abstract: "abstract1",
                    byline: "byline1",
                    url: "url1"),
                Story(
                    section: "section2",
                    subsection: "subsection2",
                    title: "title2",
                    abstract: "abstract2",
                    byline: "byline2",
                    url: "url2")
            ])

        let sessionMock = URLSessionMock(
            responses: [
                (json: topStories.json, error: nil, dataTask: URLSessionDataTaskMock())
            ]
        )
        
        app.launch(.start, with: sessionMock)
        
        XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        XCTAssertEqual(app.tables.firstMatch.cells.count, 2)
        XCTAssertTrue(app.staticTexts[topStories.results.first!.title].isHittable)
        XCTAssertTrue(app.staticTexts[topStories.results.first!.byline].isHittable)
        XCTAssertTrue(app.staticTexts[topStories.results.last!.title].isHittable)
        XCTAssertTrue(app.staticTexts[topStories.results.last!.byline].isHittable)
        
        for index in 0...topStories.results.count - 1 {
            app.tables.firstMatch.cells.element(boundBy: index).buttons.firstMatch.tap()
            XCTAssertTrue(app.navigationBars["\(topStories.results[index].section) - \(topStories.results[index].subsection)"].isHittable)
            app.buttons["Top Stories"].tap()
            XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        }
    }
}
