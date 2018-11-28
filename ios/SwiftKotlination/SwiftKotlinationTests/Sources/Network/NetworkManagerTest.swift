import XCTest
@testable import SwiftKotlination

final class NetworkManagerTest: XCTestCase {

    var sut: NetworkManager!

    func testObserveRequestSuccessfully() {
        let file = File("top_stories", .json)
        let responses = [
            Response(file)
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
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
        XCTAssertTrue(session.responses.isEmpty)
        responses.forEach { response in
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
        let responses = [
            Response(file),
            Response(file)
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
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
        XCTAssertTrue(session.responses.isEmpty)
        responses.forEach { response in
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
        let responses = [
            Response(file),
            Response(error: .invalidResponse),
            Response(file)
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
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
        XCTAssertTrue(session.responses.isEmpty)
        responses.forEach { response in
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
