import XCTest
@testable import SwiftKotlination

final class TopStoriesUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()
    
    func testFeatureTopStoriesSuccess() {
        let sessionMock = URLSessionMock(
            responses: [
                Response(File("top_stories", .json))
            ]
        )
        
        app.launch(.start, with: sessionMock)
        
        XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        
        let storyLines = [
            (title: "Donald Trump, Australia, Hawaii: Your Friday Briefing", byline: "By CHRIS STANFORD", category: "Briefing"),
            (title: "New York Today: A Leonard Bernstein Centennial", byline: "By JONATHAN WOLFE", category: "New York - Music"),
        ]
        
        XCTAssertEqual(app.tables.firstMatch.cells.count, storyLines.count)
        
        for index in 0...storyLines.count - 1 {
            XCTAssertTrue(app.staticTexts[storyLines[index].title].isHittable)
            XCTAssertTrue(app.staticTexts[storyLines[index].byline].isHittable)
            
            app.tables.firstMatch.cells.element(boundBy: index).tap()
            
            XCTAssertTrue(app.navigationBars[storyLines[index].category].isHittable)
            app.buttons["Top Stories"].tap()
            XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        }
    }
    
    func testFeatureTopStoriesFailure() {
        let sessionMock = URLSessionMock(
            responses: [
                Response(error: .invalidResponse)
            ]
        )
        
        app.launch(.start, with: sessionMock)
        
        XCTAssertEqual(app.tables.firstMatch.cells.count, 0)
        
        app.alerts["Error"].buttons["Ok"].tap()
    }
}
