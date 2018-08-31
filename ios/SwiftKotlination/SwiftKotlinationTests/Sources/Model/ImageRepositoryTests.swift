import XCTest
@testable import SwiftKotlination

final class ImageRepositoryTest: XCTestCase {
    
    var sut: ImageRepository!
    
    func testImageRepositoryFetchesImageSuccessfully() {
        guard
            let data = File("27arizpolitics7-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {
                
            XCTFail("Invalid image")
            return
        }
        
        let apiClient = APIClientMock(result: .success(data))
        sut = ImageRepository(apiClient: apiClient)
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let image):
                    XCTAssertEqual(UIImagePNGRepresentation(image), UIImagePNGRepresentation(expectedImage))
                    
                case .failure(let error):
                    XCTFail("Fetch Image should succeed, found error \(error)")
                }
        }
    }
    
    func testImageRepositoryFetchesImageUnsuccessfully() {
        let apiClient = APIClientMock(result: .failure(NetworkError.invalidResponse))
        sut = ImageRepository(apiClient: apiClient)
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let image):
                    XCTFail("Fetch Image should fail, found image \(image)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
        }
    }
    
    func testImageRepositoryFetchesImageOnceSuccessfullyAndOnceUnsuccessfully() {
        guard
            let data = File("27arizpolitics7-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {
                
                XCTFail("Invalid image")
                return
        }
        
        let apiClient = APIClientMock(result: .success(data))
        sut = ImageRepository(apiClient: apiClient)
        
        var times = 0
        
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let image):
                    XCTAssertEqual(UIImagePNGRepresentation(image), UIImagePNGRepresentation(expectedImage))
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
        }
        
        apiClient.result = .failure(NetworkError.invalidRequest)
        
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let image):
                    XCTFail("Fetch Image should fail, found image \(image)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidRequest)
                }
                times += 1
        }
        
        XCTAssertEqual(times, 3)
    }
}
