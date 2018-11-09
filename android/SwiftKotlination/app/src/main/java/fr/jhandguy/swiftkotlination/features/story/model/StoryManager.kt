package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

interface StoryManagerInterface {
    suspend fun story(observer: Observer<Story>)
}

class StoryManager(private val story: Story): StoryManagerInterface {
    override suspend fun story(observer: Observer<Story>) = observer(Result.Success(story))
}