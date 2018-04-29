import UIKit

protocol CoordinatorProtocol: class {
    func start()
}

final class Coordinator: CoordinatorProtocol {
    
    private var window: UIWindow!
    private let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController.create(viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
