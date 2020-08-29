@testable import StoryKit

final class StoryCoordinatorDelegateMock {
    private(set) var openedUrl: String?
}

extension StoryCoordinatorDelegateMock: StoryCoordinatorDelegate {
    func storyCoordinator(_: StoryCoordinator, didOpenUrl url: String) {
        openedUrl = url
    }
}
