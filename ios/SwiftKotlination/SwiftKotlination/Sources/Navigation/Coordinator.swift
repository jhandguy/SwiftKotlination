import UIKit
import SafariServices

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
    func open(_ url: URL)
}

final class Coordinator: CoordinatorProtocol {
    private var window: UIWindow
    private let apiClient: APIClientProtocol
    internal let navigationController = UINavigationController()
    
    init(window: UIWindow, apiClient: APIClientProtocol) {
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
        self.apiClient = apiClient
    }
    
    func start() {
        let viewController = TopStoriesViewController()
        viewController.viewModel = TopStoriesViewModel(repository: TopStoriesRepository(apiClient: apiClient))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func open(_ story: Story) {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(repository: StoryRepository(story: story))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func open(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}
