package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.Result

interface StoryRepository {
    suspend fun story(observer: (Result<Story>) -> Unit)
}

class StoryRepositoryImpl(private val story: Story): StoryRepository {
    override suspend fun story(observer: (Result<Story>) -> Unit) = observer(Result.Success(story))
}