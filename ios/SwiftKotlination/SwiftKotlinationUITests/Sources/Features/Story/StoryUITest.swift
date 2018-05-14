import XCTest

final class StoryUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()
    
    func testFeatureStory() {
        let story = Story(
            section: "section",
            subsection: "subsection",
            title: "title",
            abstract: "abstract",
            byline: "byline",
            url: "url"
        )
        
        app.launch(.open(story))
        
        XCTAssertTrue(app.navigationBars["\(story.section) - \(story.subsection)"].isHittable)
        XCTAssertTrue(app.staticTexts[story.title].isHittable)
        XCTAssertTrue(app.staticTexts[story.abstract].isHittable)
        XCTAssertTrue(app.staticTexts[story.byline].isHittable)
        XCTAssertTrue(app.buttons["See More"].isHittable)
    }
}
