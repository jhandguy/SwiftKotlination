import UIKit

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
}

final class Coordinator: CoordinatorProtocol {
    
    private var window: UIWindow
    private var apiClient: APIClientProtocol
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
}
