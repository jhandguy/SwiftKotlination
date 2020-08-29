import StoryKit
import TestKit
import TopStoriesKit

struct FactoryMock {
    let topStoriesFactory: TopStoriesFactoryMock
    let storyFactory: StoryFactoryMock

    init(
        topStoriesFactory: TopStoriesFactoryMock = TopStoriesFactoryMock(),
        storyFactory: StoryFactoryMock = StoryFactoryMock()
    ) {
        self.topStoriesFactory = topStoriesFactory
        self.storyFactory = storyFactory
    }
}

extension FactoryMock: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        topStoriesFactory.makeTopStoriesManager()
    }

    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        topStoriesFactory.makeTopStoriesTableViewController()
    }
}

extension FactoryMock: StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol {
        storyFactory.makeStoryManager(for: story)
    }

    func makeStoryViewController(for story: Story) -> StoryViewController {
        storyFactory.makeStoryViewController(for: story)
    }
}
