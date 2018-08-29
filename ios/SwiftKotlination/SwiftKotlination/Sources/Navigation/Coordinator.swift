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
        guard let viewController = TopStoriesTableViewController.storyBoardInstance else {
            return
        }
        let topStoriesRepository = TopStoriesRepository(apiClient: apiClient)
        let imageRepository = ImageRepository(apiClient: apiClient)
        viewController.viewModel = TopStoriesViewModel(topStoriesRepository: topStoriesRepository, imageRepository: imageRepository)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func open(_ story: Story) {
        guard let viewController = StoryViewController.storyBoardInstance else {
            return
        }
        let storyRepository = StoryRepository(story: story)
        let imageRepository = ImageRepository(apiClient: apiClient)
        viewController.viewModel = StoryViewModel(storyRepository: storyRepository, imageRepository: imageRepository)
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
