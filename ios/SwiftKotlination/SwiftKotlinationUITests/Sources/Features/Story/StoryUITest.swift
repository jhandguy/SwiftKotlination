import XCTest

final class StoryUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()
    
    func testFeatureStory() {
        let story = Story(
            section: "New York",
            subsection: "Music",
            title: "New York Today: A Leonard Bernstein Centennial",
            abstract: "Friday: Remembering a music man and your favorite things about fall.",
            byline: "By JONATHAN WOLFE",
            url: "https://www.nytimes.com/2018/08/24/nyregion/new-york-today-leonard-bernstein-centennial.html"
        )
        
        app.launch(.openStory(story))
        
        XCTAssertTrue(app.navigationBars["\(story.section) - \(story.subsection)"].isHittable)
        XCTAssertTrue(app.staticTexts[story.title].isHittable)
        XCTAssertTrue(app.staticTexts[story.abstract].isHittable)
        XCTAssertTrue(app.staticTexts[story.byline].isHittable)
        
        app.buttons["See More"].tap()
        
        XCTAssertTrue(app.buttons["\(story.section) - \(story.subsection)"].isHittable)
        
        app.buttons["\(story.section) - \(story.subsection)"].tap()
        
        XCTAssertTrue(app.navigationBars["\(story.section) - \(story.subsection)"].isHittable)
    }
}
