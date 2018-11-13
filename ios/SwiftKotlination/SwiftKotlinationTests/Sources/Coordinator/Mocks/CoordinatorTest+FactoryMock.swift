@testable import SwiftKotlination
import Foundation

extension CoordinatorTest {
    struct FactoryMock {
        let topStoriesFactory: TopStoriesFactoryMock
        let storyFactory: StoryFactoryMock

        init(topStoriesFactory: TopStoriesFactoryMock = TopStoriesFactoryMock(), storyFactory: StoryFactoryMock = StoryFactoryMock()) {
            self.topStoriesFactory = topStoriesFactory
            self.storyFactory = storyFactory
        }
    }
}

extension CoordinatorTest.FactoryMock: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        return topStoriesFactory.makeTopStoriesManager()
    }
    
    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        return topStoriesFactory.makeTopStoriesTableViewController()
    }
}

extension CoordinatorTest.FactoryMock: StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol {
        return storyFactory.makeStoryManager(for: story)
    }
    
    func makeStoryViewController(for story: Story) -> StoryViewController {
        return storyFactory.makeStoryViewController(for: story)
    }
}
