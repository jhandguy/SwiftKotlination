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

        let request = Request.fetchTopStories
        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
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

        guard let observers = sut.observables[request] else {
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

        let request = Request.fetchTopStories
        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
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

        guard let observers = sut.observables[request] else {
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

        let request = Request.fetchTopStories
        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure(let error):
                    XCTFail("Execute request should succeed, found error \(error)")
                }
                times += 1
            }.disposed(by: disposeBag)

        sut
            .observe(request) { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, file.data)
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }.disposed(by: disposeBag)

        sut.execute(request)

        XCTAssertEqual(times, 4)
        XCTAssertTrue(session.responses.isEmpty)
        responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[request] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveInvalidRequestUnsuccessfully() {
        let responses = [
            Response()
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let request = Request.fetchImage("")
        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case .success(let data):
                    XCTFail("Execute request should fail, found data \(String(describing: data.json))")
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)
        XCTAssertFalse(session.responses.isEmpty)
        responses.forEach { response in
            XCTAssertFalse(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[request] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }

    func testObserveInvalidResponseUnsuccessfully() {
        let responses = [
            Response()
        ]
        let session = URLSessionMock(responses: responses)
        sut = NetworkManager(session: session)

        let request = Request.fetchImage("url")
        let disposeBag = DisposeBag()
        var times = 0

        sut
            .observe(request) { result in
                switch result {
                case .success(let data):
                    XCTFail("Execute request should fail, found data \(String(describing: data.json))")
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
                times += 1
            }.disposed(by: disposeBag)

        XCTAssertEqual(times, 1)
        XCTAssertTrue(session.responses.isEmpty)
        responses.forEach { response in
            XCTAssertTrue(response.dataTask.isResumed)
        }

        disposeBag.dispose()

        guard let observers = sut.observables[request] else {
            XCTFail("Expected observables to not be nil")
            return
        }
        XCTAssertTrue(observers.isEmpty)
    }
}
