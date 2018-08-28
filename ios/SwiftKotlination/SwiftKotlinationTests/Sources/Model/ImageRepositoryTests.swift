import XCTest
@testable import SwiftKotlination

final class ImageRepositoryTest: XCTestCase {
    
    var sut: ImageRepository!
    
    func testImageRepositoryFetchesImageSuccessfully() {
        guard
            let image = UIImage(named: "Empty Placeholder Image"),
            let expectedData = UIImagePNGRepresentation(image) else {
                
            XCTFail("Invalid image")
            return
        }
        
        let apiClient = APIClientMock(result: .success(expectedData))
        sut = ImageRepository(apiClient: apiClient)
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, expectedData)
                    
                case .failure(let error):
                    XCTFail("Fetch Image should succeed, found error \(error)")
                }
        }
        
        apiClient.result = .failure(NetworkError.invalidResponse)
        
        sut
            .image(with: "url") { result in
                switch result {
                case .success(let data):
                    XCTAssertEqual(data, expectedData)
                    
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
                case .success(let data):
                    XCTFail("Fetch Image should fail, found image with data \(data)")
                    
                case .failure(let error):
                    XCTAssertEqual(error as? NetworkError, .invalidResponse)
                }
        }
    }
}
