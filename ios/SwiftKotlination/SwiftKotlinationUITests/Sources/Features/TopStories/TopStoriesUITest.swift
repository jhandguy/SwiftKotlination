import XCTest
@testable import SwiftKotlination

final class TopStoriesUITest: XCTestCase {
    private lazy var app: XCUIApplication = XCUIApplication()

    override func setUp() {
        super.setUp()
        setupSnapshot(app)
    }

    func testFeatureTopStoriesSuccessfully() {
        let topStories = [
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

        TopStoriesRobot(app)
            .checkTitle(contains: "Top Stories")
            .takeScreenshot(named: "Top Stories")
            .checkTopStoriesCount(is: topStories.count)
            .forEach(topStories: [0, 1]) { robot, index in
                let story = topStories[index]
                robot
                    .checkTopStoryTitle(contains: story.title)
                    .checkTopStoryByline(contains: story.byline)
                    .openStory(at: index)
                    .checkTitle(contains: story.category)
                    .closeStory()
            }
            .checkTitle(contains: "Top Stories")
            .checkTopStoriesCount(is: topStories.count)
            .refreshTopStories()
            .closeErrorAlert()
    }
}
