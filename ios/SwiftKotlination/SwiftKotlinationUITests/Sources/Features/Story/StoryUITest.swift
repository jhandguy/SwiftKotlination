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
            url: "https://url.com"
        )
        
        app.launch(.openStory(story))
        
        XCTAssertTrue(app.navigationBars["\(story.section) - \(story.subsection)"].isHittable)
        XCTAssertTrue(app.staticTexts[story.title].isHittable)
        XCTAssertTrue(app.staticTexts[story.abstract].isHittable)
        XCTAssertTrue(app.staticTexts[story.byline].isHittable)
        XCTAssertTrue(app.buttons["See More"].isHittable)
        
        app.buttons["See More"].tap()
        
        XCTAssertTrue(app.buttons["\(story.section) - \(story.subsection)"].isHittable)
        
        app.buttons["\(story.section) - \(story.subsection)"].tap()
        
        XCTAssertTrue(app.navigationBars["\(story.section) - \(story.subsection)"].isHittable)
    }
}
