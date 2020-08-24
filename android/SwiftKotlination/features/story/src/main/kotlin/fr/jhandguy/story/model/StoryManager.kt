package fr.jhandguy.story.model

import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result

interface StoryManagerInterface {
    suspend fun story(observer: Observer<Story>)
}

class StoryManager(private val story: Story) : StoryManagerInterface {
    override suspend fun story(observer: Observer<Story>) = observer(Result.Success(story))
}
