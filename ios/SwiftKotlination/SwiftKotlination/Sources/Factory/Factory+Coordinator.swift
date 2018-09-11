import UIKit

protocol CoordinatorFactory {
    func makeCoordinator(for window: UIWindow) -> CoordinatorProtocol
}

extension Factory: CoordinatorFactory {

    // MARK: - Internal Methods

    func makeCoordinator(for window: UIWindow) -> CoordinatorProtocol {
        return Coordinator(window: window, factory: self)
    }
}
