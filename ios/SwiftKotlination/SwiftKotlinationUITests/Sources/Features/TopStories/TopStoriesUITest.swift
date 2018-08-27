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
            (
                title: "Preliminary Nafta Deal Reached Between U.S. and Mexico",
                byline: "By ANA SWANSON and KATIE ROGERS",
                category: "U.S. - Politics"
            ),
            (
                title: "Arizona Governor Faces a Tough Choice: A Senator Made From McCain’s Mold or Trump’s",
                byline: "By JONATHAN MARTIN",
                category: "U.S."
            )
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
