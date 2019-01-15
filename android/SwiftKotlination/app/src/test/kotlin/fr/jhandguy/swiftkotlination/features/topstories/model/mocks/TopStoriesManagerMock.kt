package fr.jhandguy.swiftkotlination.features.topstories.model.mocks

import fr.jhandguy.swiftkotlination.features.topstories.model.TopStories
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class TopStoriesManagerMock(var result: Result<TopStories>, var observer: Observer<TopStories> = {}) : TopStoriesManagerInterface {
    override suspend fun topStories(observer: Observer<TopStories>): Disposable {
        this.observer = observer
        observer(result)

        return Disposable {}
    }

    override suspend fun fetchStories() = observer(result)
}