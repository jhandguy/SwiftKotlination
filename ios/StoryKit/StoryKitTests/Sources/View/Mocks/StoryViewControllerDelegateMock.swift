@testable import StoryKit

final class StoryViewControllerDelegateMock {
    private(set) var tappedUrl: String?
}

extension StoryViewControllerDelegateMock: StoryViewControllerDelegate {
    func storyViewController(_: StoryViewController, didTouchUpInsideUrl url: String) {
        tappedUrl = url
    }
}
