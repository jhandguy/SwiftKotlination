@testable import ImageKit
import NetworkKit
import TestKit
import XCTest

final class ImageManagerTest: XCTestCase {
    private var sut: ImageManager!

    func testImageManagerFetchesImageSuccessfully() throws {
        let imageData = try XCTUnwrap(File("27arizpolitics7-thumbLarge", .jpg).data)
        let networkManager = NetworkManagerMock(result: .success(imageData))
        sut = ImageManager(networkManager: networkManager)
        sut
            .image(with: "url") { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, imageData)

                case let .failure(error):
                    XCTFail("Fetch Image should succeed, found error \(error)")
                }
            }
    }

    func testImageManagerFetchesImageUnsuccessfully() {
        let networkManager = NetworkManagerMock(result: .failure(NetworkError.invalidResponse))
        sut = ImageManager(networkManager: networkManager)
        sut
            .image(with: "url") { result in
                switch result {
                case let .success(data):
                    XCTFail("Fetch Image should fail, found data \(data)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testImageManagerFetchesImageOnceSuccessfullyAndOnceUnsuccessfully() throws {
        let imageData = try XCTUnwrap(File("27arizpolitics7-thumbLarge", .jpg).data)
        let networkManager = NetworkManagerMock(result: .success(imageData))
        sut = ImageManager(networkManager: networkManager)

        var times = 0

        sut
            .image(with: "url") { result in
                switch result {
                case let .success(data):
                    XCTAssertEqual(data, imageData)

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }

        networkManager.result = .failure(NetworkError.invalidRequest)

        sut
            .image(with: "url") { result in
                switch result {
                case let .success(data):
                    XCTFail("Fetch Image should fail, found data \(data)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }

        XCTAssertEqual(times, 3)
    }
}
