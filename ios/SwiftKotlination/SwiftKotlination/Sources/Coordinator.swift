import UIKit

protocol CoordinatorProtocol: class {
    func start()
    func open(_ story: Story)
}

final class Coordinator: CoordinatorProtocol {
    
    private var window: UIWindow!
    internal let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let viewController = TopStoriesViewController()
        viewController.viewModel = TopStoriesViewModel(repository: TopStoriesRepository(apiClient: APIClient()))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func open(_ story: Story) {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(repository: StoryRepository(story))
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
