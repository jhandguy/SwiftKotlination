import StoryKit
@testable import TopStoriesKit

final class TopStoriesTableViewControllerDelegateMock {
    private(set) var selectedStory: Story?
}

extension TopStoriesTableViewControllerDelegateMock: TopStoriesTableViewControllerDelegate {
    func topStoriesTableViewController(_: TopStoriesTableViewController, didSelectStory story: Story) {
        selectedStory = story
    }
}
