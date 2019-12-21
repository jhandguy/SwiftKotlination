import StoryKit
import UIKit

public final class StoryCoordinatorMock {
    public weak var delegate: StoryCoordinatorDelegate?

    public private(set) var isStarted = false
    public private(set) var story: Story?

    public init() {}
}

extension StoryCoordinatorMock: StoryCoordinatorProtocol {
    public func start(with story: Story) -> UIViewController {
        isStarted = true
        self.story = story

        return UIViewController()
    }
}
