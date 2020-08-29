import ImageKit
import NetworkKit
import StoryKit
import TopStoriesKit

struct DependencyManager {
    let networkManager: NetworkManagerProtocol
}

extension DependencyManager: ImageFactory {
    func makeImageManager() -> ImageManagerProtocol {
        ImageManager(networkManager: networkManager)
    }
}

extension DependencyManager: StoryFactory {
    func makeStoryManager(for story: Story) -> StoryManagerProtocol {
        StoryManager(story: story)
    }

    func makeStoryViewController(for story: Story) -> StoryViewController {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(factory: self, story: story)

        return viewController
    }
}

extension DependencyManager: TopStoriesFactory {
    func makeTopStoriesManager() -> TopStoriesManagerProtocol {
        TopStoriesManager(networkManager: networkManager)
    }

    func makeTopStoriesTableViewController() -> TopStoriesTableViewController {
        let viewController = TopStoriesTableViewController()
        viewController.viewModel = TopStoriesViewModel(factory: self)

        return viewController
    }
}
