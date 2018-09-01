import XCTest
@testable import SwiftKotlination

final class TopStoriesUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()

    override func setUp() {
        super.setUp()
        setupSnapshot(app)
    }

    func testFeatureTopStoriesSuccessfully() {
        let sessionMock = URLSessionMock(
            responses: [
                Response(File("top_stories", .json)),
                Response(File("28DC-nafta-thumbLarge", .jpg)),
                Response(File("27arizpolitics7-thumbLarge", .jpg)),
                Response(File("28DC-nafta-superJumbo-v2", .jpg)),
                Response(File("top_stories", .json)),
                Response(File("27arizpolitics7-superJumbo-v2", .jpg)),
                Response(File("top_stories", .json)),
                Response(error: .invalidResponse)
            ]
        )

        app.launch(.start, with: sessionMock)

        XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        XCTAssertTrue(app.tables.firstMatch.isHittable)

        snapshot("Top Stories")

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

        for index in 0...storyLines.count - 1 {
            XCTAssertEqual(app.tables.firstMatch.cells.count, storyLines.count)
            XCTAssertTrue(app.staticTexts[storyLines[index].title].isHittable)
            XCTAssertTrue(app.staticTexts[storyLines[index].byline].isHittable)

            app.tables.firstMatch.cells.element(boundBy: index).tap()

            XCTAssertTrue(app.navigationBars[storyLines[index].category].isHittable)

            app.buttons["Top Stories"].tap()

            XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
            XCTAssertTrue(app.tables.firstMatch.isHittable)
        }

        app.tables.firstMatch.refresh()

        XCTAssertFalse(app.navigationBars["Top Stories"].isHittable)
        XCTAssertFalse(app.tables.firstMatch.isHittable)

        app.alerts["Error"].buttons["Ok"].tap()

        XCTAssertTrue(app.navigationBars["Top Stories"].isHittable)
        XCTAssertTrue(app.tables.firstMatch.isHittable)
    }
}
