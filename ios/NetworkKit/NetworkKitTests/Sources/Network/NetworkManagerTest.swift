@testable import NetworkKit
import TestKit
import XCTest

final class NetworkManagerTest: XCTestCase {
    private var sut: NetworkManager!

    func testObserveRequestSuccessfully() throws {
        let request = Request.fetchTopStories
        let file = File("top_stories", .json)
        let responses = [
            request: [
                Response(file),
            ],
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, file.data)
                case let .failure(error):
                    XCTFail("Observe on request should succeed, found error \(error)")
                }
                times += 1
            }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)

        let sessionResponses = try XCTUnwrap(session.responses[request.absoluteUrl])
        XCTAssertTrue(sessionResponses.isEmpty)

        let mockResponses = try XCTUnwrap(responses[request])
        mockResponses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        let observers = try XCTUnwrap(sut.observables[request])
        XCTAssertTrue(observers.isEmpty)
    }

    func testExecuteRequestSuccessfully() throws {
        let request = Request.fetchTopStories
        let file = File("top_stories", .json)
        let responses = [
            request: [
                Response(file),
                Response(file),
            ],
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, file.data)
                case let .failure(error):
                    XCTFail("Execute request should succeed, found error \(error)")
                }
                times += 1
            }.disposed(by: disposeBag)

        sut.execute(.fetchTopStories)

        XCTAssertEqual(times, 2)

        let sessionResponses = try XCTUnwrap(session.responses[request.absoluteUrl])
        XCTAssertTrue(sessionResponses.isEmpty)

        let mockResponses = try XCTUnwrap(responses[request])
        mockResponses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        let observers = try XCTUnwrap(sut.observables[request])
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveRequestSeveralTimesAndExecuteSuccessfully() throws {
        let request = Request.fetchTopStories
        let file = File("top_stories", .json)
        let responses = [
            request: [
                Response(file),
                Response(error: .invalidResponse),
                Response(file),
            ],
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, file.data)
                case let .failure(error):
                    XCTFail("Execute request should succeed, found error \(error)")
                }
                times += 1
            }.disposed(by: disposeBag)

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, file.data)
                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }.disposed(by: disposeBag)

        sut.execute(request)

        XCTAssertEqual(times, 4)

        let sessionResponses = try XCTUnwrap(session.responses[request.absoluteUrl])
        XCTAssertTrue(sessionResponses.isEmpty)

        let mockResponses = try XCTUnwrap(responses[request])
        mockResponses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        let observers = try XCTUnwrap(sut.observables[request])
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveInvalidRequestUnsuccessfully() throws {
        let request = Request.fetchImage("")
        let responses = [
            request: [
                Response(),
            ],
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTFail("Execute request should fail, found data \(String(describing: data.json))")
                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)

        let sessionResponses = try XCTUnwrap(session.responses[request.absoluteUrl])
        XCTAssertFalse(sessionResponses.isEmpty)

        let mockResponses = try XCTUnwrap(responses[request])
        mockResponses.forEach { response in
            XCTAssertFalse(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        let observers = try XCTUnwrap(sut.observables[request])
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveInvalidResponseUnsuccessfully() throws {
        let request = Request.fetchImage("url")
        let responses = [
            request: [
                Response(),
            ],
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case let .success(data):
                    XCTFail("Execute request should fail, found data \(String(describing: data.json))")
                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)

        let sessionResponses = try XCTUnwrap(session.responses[request.absoluteUrl])
        XCTAssertTrue(sessionResponses.isEmpty)

        let mockResponses = try XCTUnwrap(responses[request])
        mockResponses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        let observers = try XCTUnwrap(sut.observables[request])
        XCTAssertTrue(observers.isEmpty)
    }
}
