import ImageKit

public struct ImageFactoryMock {
    public let imageManager: ImageManagerMock

    public init(imageManager: ImageManagerMock) {
        self.imageManager = imageManager
    }
}

extension ImageFactoryMock: ImageFactory {
    public func makeImageManager() -> ImageManagerProtocol {
        imageManager
    }
}
