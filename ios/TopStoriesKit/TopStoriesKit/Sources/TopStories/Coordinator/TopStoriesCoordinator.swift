import StoryKit
import UIKit

public protocol TopStoriesCoordinatorDelegate: AnyObject {
    func topStoriesCoordinator(_ topStoriesCoordinator: TopStoriesCoordinator, didOpenStory story: Story)
}

public protocol TopStoriesCoordinatorProtocol: AnyObject {
    var delegate: TopStoriesCoordinatorDelegate? { get set }

    func start() -> UIViewController
}

public final class TopStoriesCoordinator {
    public weak var delegate: TopStoriesCoordinatorDelegate?

    private let factory: TopStoriesFactory

    public init(factory: TopStoriesFactory) {
        self.factory = factory
    }
}

extension TopStoriesCoordinator: TopStoriesCoordinatorProtocol {
    public func start() -> UIViewController {
        let viewController = factory.makeTopStoriesTableViewController()
        viewController.delegate = self
        return viewController
    }
}

extension TopStoriesCoordinator: TopStoriesTableViewControllerDelegate {
    func topStoriesTableViewController(
        _: TopStoriesTableViewController,
        didSelectStory story: Story
    ) {
        delegate?.topStoriesCoordinator(self, didOpenStory: story)
    }
}
