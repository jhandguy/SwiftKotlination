import UIKit
import SafariServices

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
    func open(_ url: String)
}

final class Coordinator {

    typealias Factory = TopStoriesFactory & StoryFactory

    private let factory: Factory
    private let window: UIWindow

    let navigationController = UINavigationController()

    init(factory: Factory, window: UIWindow) {
        self.factory = factory
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

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

    func open(_ url: String) {
        guard
            let url = URL(string: url),
            UIApplication.shared.canOpenURL(url) else {
                return
        }
        let viewController = SFSafariViewController(url: url)
        navigationController.present(viewController, animated: true)
    }
}
