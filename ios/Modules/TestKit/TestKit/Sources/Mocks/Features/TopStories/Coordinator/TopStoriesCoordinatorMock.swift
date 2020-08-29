import TopStoriesKit
import UIKit

public final class TopStoriesCoordinatorMock {
    public weak var delegate: TopStoriesCoordinatorDelegate?

    public private(set) var isStarted = false

    public init() {}
}

extension TopStoriesCoordinatorMock: TopStoriesCoordinatorProtocol {
    public func start() -> UIViewController {
        isStarted = true

        return UIViewController()
    }
}
