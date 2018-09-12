import XCTest
@testable import SwiftKotlination

final class TopStoriesManagerTest: XCTestCase {

    var sut: TopStoriesManager!

    func testTopStoriesManagerFetchesTopStoriesSuccessfully() {
        let topStories = TopStories(
            results: [
                Story(
                    section: "Briefing",
                    subsection: "",
                    title: "Kirstjen Nielsen, Spotify, Cannes Film Festival: Your Friday Briefing",
                    abstract: "Here’s what you need to know to start your day.",
                    byline: "By CHRIS STANFORD",
                    url: "https://www.nytimes.com/2018/05/11/briefing/kirstjen-nielsen-spotify-cannes-film-festival.html",
                    multimedia: [
                        Multimedia(
                            url: "https://static01.nyt.com/images/2018/05/11/world/11us-ambriefing-israel-sub/merlin_137938851_81051c92-3244-40b6-8034-99ca55739e43-superJumbo.jpg",
                            format: .large
                        )
                    ]
                )
            ]
        )
        guard let data = topStories.data else {
            XCTFail("Invalid data")
            return
        }

        let networkManager = NetworkManagerMock(result: .success(data))
        sut = TopStoriesManager(networkManager: networkManager)
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories, topStories.results)

                case .failure(let error):
                    XCTFail("Fetch TopStories should succeed, found error \(error)")
                }
        }
    }

    func testTopStoriesManagerFetchesTopStoriesUnsuccessfully() {
        let networkManager = NetworkManagerMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesManager(networkManager: networkManager)
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Fetch TopStories should fail, found stories \(stories)")

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
        }
    }

    func testTopStoriesManagerFetchesTopStoriesOnceSuccessfullyAndTwiceUnsuccessfully() {
        let topStories = TopStories(
            results: [
                Story(
                    section: "Briefing",
                    subsection: "",
                    title: "Kirstjen Nielsen, Spotify, Cannes Film Festival: Your Friday Briefing",
                    abstract: "Here’s what you need to know to start your day.",
                    byline: "By CHRIS STANFORD",
                    url: "https://www.nytimes.com/2018/05/11/briefing/kirstjen-nielsen-spotify-cannes-film-festival.html",
                    multimedia: [
                        Multimedia(
                            url: "https://static01.nyt.com/images/2018/05/11/world/11us-ambriefing-israel-sub/merlin_137938851_81051c92-3244-40b6-8034-99ca55739e43-superJumbo.jpg",
                            format: .large
                        )
                    ]
                )
            ]
        )
        guard let data = topStories.data else {
            XCTFail("Invalid data")
            return
        }

        let networkManager = NetworkManagerMock(result: .success(data))
        sut = TopStoriesManager(networkManager: networkManager)

        var times = 0

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories, topStories.results)

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
        }

        XCTAssertEqual(times, 1)

        networkManager.result = .failure(NetworkError.invalidRequest)

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Fetch TopStories for the second time should fail, found stories \(stories)")

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
        }

        XCTAssertEqual(times, 3)

        sut.fetchStories()

        XCTAssertEqual(times, 5)
    }
}
