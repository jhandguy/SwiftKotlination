import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryTest: XCTestCase {
    
    var sut: TopStoriesRepository!
    
    func testTopStoriesRepositoryStories() {
        let topStories = TopStories(
            results: [
                Story(
                    section: "Briefing",
                    subsection: "",
                    title: "Kirstjen Nielsen, Spotify, Cannes Film Festival: Your Friday Briefing",
                    abstract: "Here’s what you need to know to start your day.",
                    byline: "By CHRIS STANFORD",
                    url: "https://www.nytimes.com/2018/05/11/briefing/kirstjen-nielsen-spotify-cannes-film-festival.html"
                )
            ]
        )
        let apiClient = APIClientMock(result: .success(topStories.json))
        sut = TopStoriesRepository(apiClient: apiClient)
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories, topStories.results)
                    
                case .failure(let error):
                    XCTFail("Story should succeed, found error \(error)")
                }
            }
    }
}
