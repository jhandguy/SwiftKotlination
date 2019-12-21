@testable import ImageKit
import NetworkKit
import TestKit
import XCTest

final class ImageManagerTest: XCTestCase {
    private var sut: ImageManager!

    func testImageManagerFetchesImageSuccessfully() throws {
        let data = try XCTUnwrap(File("27arizpolitics7-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: data))
        let networkManager = NetworkManagerMock(result: .success(data))
        sut = ImageManager(networkManager: networkManager)
        sut
            .image(with: "url") { result in
                switch result {
                case let .success(image):
                    XCTAssertEqual(image.pngData(), expectedImage.pngData())

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
                case let .success(image):
                    XCTFail("Fetch Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
            }
    }

    func testImageManagerFetchesInvalidImageUnsuccessfully() {
        let data = Data()
        let networkManager = NetworkManagerMock(result: .success(data))
        sut = ImageManager(networkManager: networkManager)
        sut
            .image(with: "url") { result in
                switch result {
                case let .success(image):
                    XCTFail("Fetch Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidData)
                }
            }
    }

    func testImageManagerFetchesImageOnceSuccessfullyAndOnceUnsuccessfully() throws {
        let data = try XCTUnwrap(File("27arizpolitics7-thumbLarge", .jpg).data)
        let expectedImage = try XCTUnwrap(UIImage(data: data))
        let networkManager = NetworkManagerMock(result: .success(data))
        sut = ImageManager(networkManager: networkManager)

        var times = 0

        sut
            .image(with: "url") { result in
                switch result {
                case let .success(image):
                    XCTAssertEqual(image.pngData(), expectedImage.pngData())

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }

        networkManager.result = .failure(NetworkError.invalidRequest)

        sut
            .image(with: "url") { result in
                switch result {
                case let .success(image):
                    XCTFail("Fetch Image should fail, found image \(image)")

                case let .failure(error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
            }

        XCTAssertEqual(times, 3)
    }
}
