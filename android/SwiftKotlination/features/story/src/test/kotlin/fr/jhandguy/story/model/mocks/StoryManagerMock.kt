package fr.jhandguy.story.model.mocks

import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManagerInterface

class StoryManagerMock(val result: Result<Story>) : StoryManagerInterface {
    override suspend fun story(observer: Observer<Story>) = observer(result)
}
