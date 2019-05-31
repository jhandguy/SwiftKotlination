import XCTest

final class TopStoriesUITest: XCTestCase {

    private lazy var app = XCUIApplication()

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
                .fetchTopStories: [
                    Response(File("top_stories", .json)),
                    Response(File("top_stories", .json)),
                    Response(File("top_stories", .json)),
                    Response(error: .invalidResponse)
                ],
                .fetchImage("https://static01.nyt.com/images/2018/08/27/us/28DC-nafta/28DC-nafta-thumbLarge.jpg"): [
                    Response(File("28DC-nafta-thumbLarge", .jpg))
                ],
                .fetchImage("https://static01.nyt.com/images/2018/08/27/us/28DC-nafta/28DC-nafta-superJumbo-v2.jpg"): [
                    Response(File("28DC-nafta-superJumbo-v2", .jpg))
                ],
                .fetchImage("https://static01.nyt.com/images/2018/08/27/us/27arizpolitics7/27arizpolitics7-thumbLarge.jpg"): [
                    Response(File("27arizpolitics7-thumbLarge", .jpg))
                ],
                .fetchImage("https://static01.nyt.com/images/2018/08/27/us/27arizpolitics7/27arizpolitics7-superJumbo-v2.jpg"): [
                    Response(File("27arizpolitics7-superJumbo-v2", .jpg))
                ]
            ]
        )

        TopStoriesRobot(app)
            .start(with: sessionMock)
            .checkTitle(contains: "Top Stories")
            .takeScreenshot(named: "top-stories")
            .checkTopStoriesCount(is: topStories.count)
            .forEach(topStories: [0, 1]) { robot, index in
                let story = topStories[index]
                robot
                    .checkTopStoryTitle(contains: story.title, at: index)
                    .checkTopStoryByline(contains: story.byline, at: index)
                    .openStory(at: index)
                    .checkTitle(contains: story.category)
                    .back()
            }
            .checkTitle(contains: "Top Stories")
            .checkTopStoriesCount(is: topStories.count)
            .refreshTopStories()
            .checkAlert(contains: NetworkError.invalidResponse)
            .closeAlert()
    }
}
