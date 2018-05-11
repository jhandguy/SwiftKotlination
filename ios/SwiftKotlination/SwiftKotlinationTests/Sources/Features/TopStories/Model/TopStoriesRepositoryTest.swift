import XCTest
import RxSwift
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
        sut = TopStoriesRepository(apiClient: APIClientMock(dataStub: .success("top_stories")))
        sut
            .stories
            .subscribe(
                onNext: {
                    XCTAssertEqual($0.count, 1)
                    XCTAssertEqual($0.first, story)
            },
                onError: { XCTFail("Story should succeed, found error \($0)") })
            .dispose()
    }
}
