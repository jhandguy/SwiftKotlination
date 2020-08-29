import UIKit

public protocol StoryCoordinatorDelegate: AnyObject {
    func storyCoordinator(_ storyCoordinator: StoryCoordinator, didOpenUrl url: String)
}

public protocol StoryCoordinatorProtocol: AnyObject {
    var delegate: StoryCoordinatorDelegate? { get set }

    func start(with story: Story) -> UIViewController
}

public final class StoryCoordinator {
    public weak var delegate: StoryCoordinatorDelegate?

    private let factory: StoryFactory

    public init(factory: StoryFactory) {
        self.factory = factory
    }
}

extension StoryCoordinator: StoryCoordinatorProtocol {
    public func start(with story: Story) -> UIViewController {
        let viewController = factory.makeStoryViewController(for: story)
        viewController.delegate = self
        return viewController
    }
}

extension StoryCoordinator: StoryViewControllerDelegate {
    func storyViewController(_: StoryViewController, didTouchUpInsideUrl url: String) {
        delegate?.storyCoordinator(self, didOpenUrl: url)
    }
}
