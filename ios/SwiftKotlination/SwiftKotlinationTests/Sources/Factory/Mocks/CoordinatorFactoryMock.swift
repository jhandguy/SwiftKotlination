import UIKit
@testable import SwiftKotlination

struct CoordinatorFactoryMock {
    let coordinator: CoordinatorMock
}

extension CoordinatorFactoryMock: CoordinatorFactory {
    func makeCoordinator(for window: UIWindow) -> CoordinatorProtocol {
        return coordinator
    }
}
