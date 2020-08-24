package fr.jhandguy.topstories.model.mocks

import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.topstories.model.TopStories
import fr.jhandguy.topstories.model.TopStoriesManagerInterface

class TopStoriesManagerMock(var result: Result<TopStories>, var observer: Observer<TopStories> = {}) : TopStoriesManagerInterface {
    override suspend fun topStories(observer: Observer<TopStories>): Disposable {
        this.observer = observer
        observer(result)

        return Disposable {}
    }

    override suspend fun fetchStories() = observer(result)
}
