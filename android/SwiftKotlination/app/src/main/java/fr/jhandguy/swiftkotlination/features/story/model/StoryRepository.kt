package fr.jhandguy.swiftkotlination.features.story.model

import io.reactivex.Observable
import javax.inject.Inject

interface StoryRepository {
    var story: Observable<Story>
}

class StoryRepositoryImpl @Inject constructor(story: Story): StoryRepository {
    override var story: Observable<Story> = Observable.just(story)
}