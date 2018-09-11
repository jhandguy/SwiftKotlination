import UIKit
import SafariServices

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
    func open(_ url: URL)
}

final class Coordinator {

    // MARK: - Private Properties

    private let window: UIWindow
    private let factory: ViewControllerFactory

    // MARK: - Initializer

    init(window: UIWindow, factory: ViewControllerFactory) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        self.factory = factory
    }

    // MARK: - Internal Properties

    let navigationController = UINavigationController()
}

// MARK: - Protocol Methods

extension Coordinator: CoordinatorProtocol {
    func start() {
        let viewController = factory.makeTopStoriesTableViewController(with: self)
        navigationController.pushViewController(viewController, animated: true)
    }

    func open(_ story: Story) {
        let viewController = factory.makeStoryViewController(with: self, for: story)
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
