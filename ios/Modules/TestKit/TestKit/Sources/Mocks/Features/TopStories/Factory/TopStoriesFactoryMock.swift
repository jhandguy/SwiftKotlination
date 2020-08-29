import ImageKit
import TopStoriesKit

public struct TopStoriesFactoryMock {
    public let topStoriesManager: TopStoriesManagerMock
    public let imageFactory: ImageFactoryMock

    public init(
        topStoriesManager: TopStoriesManagerMock = TopStoriesManagerMock(),
        imageManager: ImageManagerMock = ImageManagerMock()
    ) {
        self.topStoriesManager = topStoriesManager
        imageFactory = ImageFactoryMock(imageManager: imageManager)
    }
}

extension TopStoriesFactoryMock: TopStoriesFactory {
    public func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController()
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }

    public func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        topStoriesManager
    }
}

extension TopStoriesFactoryMock: ImageFactory {
    public func makeImageManager() -> ImageManagerProtocol {
        imageFactory.makeImageManager()
    }
}
