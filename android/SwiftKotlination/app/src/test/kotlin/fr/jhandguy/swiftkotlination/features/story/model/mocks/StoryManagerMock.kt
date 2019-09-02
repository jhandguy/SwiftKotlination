package fr.jhandguy.swiftkotlination.features.story.model.mocks

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class StoryManagerMock(val result: Result<Story>) : StoryManagerInterface {
    override suspend fun story(observer: Observer<Story>) = observer(result)
}
