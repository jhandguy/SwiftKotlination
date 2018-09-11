import XCTest
@testable import SwiftKotlination

final class TopStoriesViewModelTest: XCTestCase {

    var sut: TopStoriesViewModel!

    func testTopStoriesViewModelFetchesTopStoriesSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(topStoriesResult: .success([story]), imageResult: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(factory: factory)

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)

                case .failure(let error):
                    XCTFail("Fetch Stories should succeed, found error \(error)")
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoriesUnsuccessfully() {
        let factory = RepositoryFactoryMock(topStoriesResult: .failure(NetworkError.invalidResponse), imageResult: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(factory: factory)

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Fetch Stories should fail, found stories \(stories)")

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoryImageSuccessfully() {
        guard
            let data = File("28DC-nafta-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {

            XCTFail("Invalid image")
            return
        }

        let factory = RepositoryFactoryMock(topStoriesResult: .failure(NetworkError.invalidResponse), imageResult: .success(expectedImage))
        sut = TopStoriesViewModel(factory: factory)

        sut
            .image(with: "") { result in
                switch result {
                case .success(let image):
                    XCTAssertEqual(UIImagePNGRepresentation(image), UIImagePNGRepresentation(expectedImage))

                case .failure(let error):
                    XCTFail("Fetch TopStory Image should succeed, found error \(error)")
                }
            }
    }

    func testTopStoriesViewModelFetchesTopStoryImageUnsuccessfully() {
        let factory = RepositoryFactoryMock(topStoriesResult: .failure(NetworkError.invalidResponse), imageResult: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(factory: factory)

        sut
            .image(with: "") { result in
                switch result {
                case .success(let image):
                    XCTFail("Fetch TopStory Image should fail, found image \(image)")

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testTopStoriesViewModelRefreshsSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let factory = RepositoryFactoryMock(topStoriesResult: .success([story]), imageResult: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(factory: factory)

        var times = 0

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTAssertEqual(stories.count, 1)
                    XCTAssertEqual(stories.first, story)

                case .failure(let error):
                    XCTFail("Refresh stories should succeed, found error \(error)")
                }
                times += 1
            }

        XCTAssertEqual(times, 1)

        sut.refresh()

        XCTAssertEqual(times, 2)
    }

    func testTopStoriesViewModelRefreshsUnsuccessfully() {
        let factory = RepositoryFactoryMock(topStoriesResult: .failure(NetworkError.invalidResponse), imageResult: .failure(NetworkError.invalidResponse))
        sut = TopStoriesViewModel(factory: factory)

        var times = 0

        sut
            .stories { result in
                switch result {
                case .success(let stories):
                    XCTFail("Refresh stories should fail, found stories \(stories)")

                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }

        XCTAssertEqual(times, 1)

        sut.refresh()

        XCTAssertEqual(times, 2)
    }
}
