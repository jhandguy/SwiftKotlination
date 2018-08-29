import XCTest
@testable import SwiftKotlination

final class TopStoriesRepositoryTest: XCTestCase {
    
    var sut: TopStoriesRepository!
    
    func testTopStoriesRepositoryFetchesTopStoriesSuccessfully() {
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
                        Multimedia(url: "https://static01.nyt.com/images/2018/05/11/world/11us-ambriefing-israel-sub/merlin_137938851_81051c92-3244-40b6-8034-99ca55739e43-superJumbo.jpg", format: .large)
                    ]
                )
            ]
        )
        guard let data = topStories.data else {
            XCTFail("Invalid data")
            return
        }
        let apiClient = APIClientMock(result: .success(data))
        sut = TopStoriesRepository(apiClient: apiClient)
        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories, topStories.results)
                    
                case .failure(let error):
                    XCTFail("Fetch TopStories should succeed, found error \(error)")
                }
            }
        
        apiClient.result = .failure(NetworkError.invalidRequest)
        
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
    
    func testTopStoriesRepositoryFetchesTopStoriesUnsuccessfully() {
        let apiClient = APIClientMock(result: .failure(NetworkError.invalidResponse))
        sut = TopStoriesRepository(apiClient: apiClient)
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
}
