import UIKit
@testable import SwiftKotlination

struct ImageFactoryMock {
    let imageManager: ImageManagerMock
}

extension ImageFactoryMock: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        return imageManager
    }
}
