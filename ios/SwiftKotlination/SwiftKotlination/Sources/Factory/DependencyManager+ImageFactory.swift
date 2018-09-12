protocol ImageFactory {
    func makeImageManager() -> ImageManagerProtocol
}

// MARK: - Protocol Methods

extension DependencyManager: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return ImageManager(networkManager: networkManager)
    }
}
