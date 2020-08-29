import SafariServices
import StoryKit
import TopStoriesKit
import UIKit

protocol CoordinatorProtocol: AnyObject {
    func start()
    func open(_ story: Story)
    func open(_ url: String)
}

final class Coordinator: CoordinatorProtocol {
    typealias Factory = TopStoriesFactory & StoryFactory

    var topStoriesCoordinator: TopStoriesCoordinatorProtocol {
        didSet {
            topStoriesCoordinator.delegate = self
        }
    }

    var storyCoordinator: StoryCoordinatorProtocol {
        didSet {
            storyCoordinator.delegate = self
        }
    }

    let navigationController = UINavigationController()

    private let window: UIWindow

    init(factory: Factory, window: UIWindow) {
        topStoriesCoordinator = TopStoriesCoordinator(factory: factory)
        storyCoordinator = StoryCoordinator(factory: factory)

        self.window = window
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()

        topStoriesCoordinator.delegate = self
        storyCoordinator.delegate = self
    }
}

extension Coordinator {
    func start() {
        let viewController = topStoriesCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }

    func open(_ story: Story) {
        let viewController = storyCoordinator.start(with: story)
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

extension Coordinator: TopStoriesCoordinatorDelegate {
    func topStoriesCoordinator(_: TopStoriesCoordinator, didOpenStory story: Story) {
        open(story)
    }
}

extension Coordinator: StoryCoordinatorDelegate {
    func storyCoordinator(_: StoryCoordinator, didOpenUrl url: String) {
        open(url)
    }
}
