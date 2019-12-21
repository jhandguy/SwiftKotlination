import StoryKit
@testable import TopStoriesKit

final class TopStoriesCoordinatorDelegateMock {
    private(set) var openedStory: Story?
}

extension TopStoriesCoordinatorDelegateMock: TopStoriesCoordinatorDelegate {
    func topStoriesCoordinator(_: TopStoriesCoordinator, didOpenStory story: Story) {
        openedStory = story
    }
}
