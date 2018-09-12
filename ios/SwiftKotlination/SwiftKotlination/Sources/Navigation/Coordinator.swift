import UIKit
import SafariServices

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
    func open(_ url: URL)
}

final class Coordinator {

    // MARK: - Private Properties

    private let factory: ViewControllerFactory
    private let window: UIWindow

    // MARK: - Internal Properties

    let navigationController = UINavigationController()

    // MARK: - Initializer

    init(factory: ViewControllerFactory, window: UIWindow) {
        self.factory = factory
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

// MARK: - Protocol Methods

extension Coordinator: CoordinatorProtocol {
    func start() {
        let viewController = factory.makeTopStoriesTableViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func open(_ story: Story) {
        let viewController = factory.makeStoryViewController(for: story)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func open(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        navigationController.present(viewController, animated: true)
    }
}
