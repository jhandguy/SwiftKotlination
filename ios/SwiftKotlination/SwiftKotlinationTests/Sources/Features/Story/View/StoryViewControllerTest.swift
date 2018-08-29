import XCTest
@testable import SwiftKotlination

final class StoryViewControllerTest: XCTestCase {
    
    var sut: StoryViewController!
    
    override func setUp() {
        super.setUp()
        
        guard let viewController = StoryViewController.storyBoardInstance else {
            XCTFail("Expected view controller story board instantiation to succeed")
            return
        }
        sut = viewController
        
        _ = sut.view
    }
    
    func testStoryViewControllerFetchesStorySuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let storyRepository = StoryRepositoryMock(result: .success(story))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut.viewWillAppear(false)
        
        XCTAssertEqual(sut.title, "\(story.section) - \(story.subsection)")
        XCTAssertEqual(sut.titleLabel.text, story.title)
        XCTAssertEqual(sut.abstractLabel.text, story.abstract)
        XCTAssertEqual(sut.bylineLabel.text, story.byline)
    }
    
    func testStoryViewControllerFetchesStoryUnsuccessfully() {
        let storyRepository = StoryRepositoryMock(result: .failure(NetworkError.invalidResponse))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = sut
        
        sut.viewWillAppear(false)
        
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    func testStoryViewControllerFetchesStoryImageSuccessfully() {
        guard
            let data = File("28DC-nafta-thumbLarge", .jpg).data,
            let expectedImage = UIImage(data: data) else {
                
                XCTFail("Invalid image")
                return
        }
        
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let storyRepository = StoryRepositoryMock(result: .success(story))
        let imageRepository = ImageRepositoryMock(result: .success(data))
        sut.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut.viewWillAppear(false)
        
        let imageIsFetched = expectation(description: "Expected image to be fetched")
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                XCTFail("Self should not be nil")
                return
            }
            
            XCTAssertFalse(self.sut.multimediaImageView.isHidden)
            
            guard let image = self.sut.multimediaImageView.image else {
                XCTFail("Invalid image view")
                return
            }
            
            XCTAssertEqual(UIImagePNGRepresentation(expectedImage), UIImagePNGRepresentation(image))
            imageIsFetched.fulfill()
        }
        wait(for: [imageIsFetched], timeout: 1)
    }
    
    func testStoryViewControllerFetchesStoryImageUnsuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [Multimedia(url: "", format: .large)])
        let storyRepository = StoryRepositoryMock(result: .success(story))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut.viewWillAppear(false)
        
        let imageIsFetched = expectation(description: "Expected image to be fetched")
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                XCTFail("Self should not be nil")
                return
            }
            XCTAssertTrue(self.sut.multimediaImageView.isHidden)
            imageIsFetched.fulfill()
        }
        wait(for: [imageIsFetched], timeout: 1)
    }
    
    func testStoryViewControllerOpensUrlSuccessfully() {
        let story = Story(section: "section", subsection: "subsection", title: "title", abstract: "abstract", byline: "byline", url: "url", multimedia: [])
        let storyRepository = StoryRepositoryMock(result: .success(story))
        let imageRepository = ImageRepositoryMock(result: .failure(NetworkError.invalidResponse))
        sut.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
        
        sut.viewWillAppear(false)
        
        let coordinator = CoordinatorMock(expectedMethods: [.openUrl])
        sut.coordinator = coordinator
        sut.urlButton.sendActions(for: .touchUpInside)
        wait(for: [coordinator.expectation], timeout: 1)
    }
}
