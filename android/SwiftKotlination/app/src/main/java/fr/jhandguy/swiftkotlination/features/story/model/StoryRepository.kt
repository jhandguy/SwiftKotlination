package fr.jhandguy.swiftkotlination.features.story.model

import io.reactivex.Observable

interface StoryRepository {
    var story: Observable<Story>
}

class StoryRepositoryImpl(story: Story): StoryRepository {
    override var story: Observable<Story> = Observable.just(story)
}