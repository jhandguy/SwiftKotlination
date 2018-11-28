import XCTest

final class StoryUITest: XCTestCase {
    private lazy var app = XCUIApplication()

    override func setUp() {
        super.setUp()
        setupSnapshot(app)
    }

    func testFeatureStorySuccessfully() {
        let story = Story(
            section: "U.S.",
            subsection: "Politics",
            title: "A Trump Endorsement Can Decide a Race. Here’s How to Get One.",
            abstract: "The president’s grip on G.O.P. primary voters is as strong as it has been since he seized the party’s nomination.",
            byline: "By JONATHAN MARTIN and MAGGIE HABERMAN",
            url: "https://www.nytimes.com/2018/08/27/us/politics/trump-endorsements.html",
            multimedia: [
                Multimedia(
                    url: "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-thumbStandard.jpg",
                    format: .icon
                ),
                Multimedia(
                    url: "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-thumbLarge.jpg",
                    format: .small
                ),
                Multimedia(
                    url: "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-articleInline.jpg",
                    format: .normal
                ),
                Multimedia(
                    url: "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-mediumThreeByTwo210.jpg",
                    format: .medium
                ),
                Multimedia(
                    url: "https://static01.nyt.com/images/2018/08/28/us/politics/28trump-endorsements1/28trump-endorsements1-superJumbo.jpg",
                    format: .large
                )
            ]
        )

        let sessionMock = URLSessionMock(
            responses: [
                Response(File("28trump-endorsements1-superJumbo", .jpg))
            ]
        )

        app.launch(.openStory(story), with: sessionMock)

        StoryRobot(app)
            .checkTitle(contains: "\(story.section) - \(story.subsection)")
            .checkStoryImage(.exists)
            .checkStoryTitle(contains: story.title)
            .checkStoryAbstract(contains: story.abstract)
            .checkStoryByline(contains: story.byline)
            .takeScreenshot(named: "Story")
            .openSafari()
            .checkSafariURL(.isHittable)
            .closeSafari()
    }
}
