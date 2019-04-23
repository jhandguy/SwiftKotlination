protocol ImageFactory {
    func makeImageManager() -> ImageManagerProtocol
}

extension DependencyManager: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return ImageManager(networkManager: networkManager)
    }
}
