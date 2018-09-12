import XCTest
@testable import SwiftKotlination

final class NetworkManagerTest: XCTestCase {

    var sut: NetworkManager!

    func testObserveRequestSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file)
            ]
        )
        let disposeBag = DisposeBag()
        sut = NetworkManager(session: session)

        var times = 0

        sut
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure(let error):
                    XCTFail("Observe on request should succeed, found error \(error)")
                }
                times += 1
        }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[.fetchTopStories] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }

    func testExecuteRequestSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file),
                Response(file)
            ]
        )
        let disposeBag = DisposeBag()
        sut = NetworkManager(session: session)

        var times = 0

        sut
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure(let error):
                    XCTFail("Execute request should succeed, found error \(error)")
                }
                times += 1
        }.disposed(by: disposeBag)

        sut.execute(.fetchTopStories)

        XCTAssertEqual(times, 2)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[.fetchTopStories] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveRequestSeveralTimesAndExecuteSuccessfully() {
        let file = File("top_stories", .json)
        let session = URLSessionMock(
            responses: [
                Response(file),
                Response(error: .invalidResponse),
                Response(file)
            ]
        )
        let disposeBag = DisposeBag()
        sut = NetworkManager(session: session)

        var times = 0

        sut
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure:
                    break
                }
                times += 1
        }.disposed(by: disposeBag)

        sut
            .observe(.fetchTopStories) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
        }.disposed(by: disposeBag)

        sut.execute(.fetchTopStories)

        XCTAssertEqual(times, 4)
        session.responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[.fetchTopStories] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }
}
