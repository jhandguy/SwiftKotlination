import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryTest: XCTestCase {
    
    var sut: TopStoriesRepository!
    
    func testTopStoriesRepositoryStories() {
        let story = Story(
            section: "Briefing",
            subsection: "",
            title: "Kirstjen Nielsen, Spotify, Cannes Film Festival: Your Friday Briefing",
            abstract: "Here’s what you need to know to start your day.",
            byline: "By CHRIS STANFORD",
            url: "https://www.nytimes.com/2018/05/11/briefing/kirstjen-nielsen-spotify-cannes-film-festival.html"
        )
        let apiClient = APIClientMock(result: .success(File(name: "top_stories", extension: .json)))
        sut = TopStoriesRepository(apiClient: apiClient)
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)
                    
                case .failure(let error):
                    XCTFail("Story should succeed, found error \(error)")
                }
            }
    }
}
