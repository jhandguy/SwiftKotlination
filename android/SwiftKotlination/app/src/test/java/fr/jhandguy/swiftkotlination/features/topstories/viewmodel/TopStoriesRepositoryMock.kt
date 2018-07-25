package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable

class TopStoriesRepositoryMock(stories: List<Story> = ArrayList(), error: Error? = null): TopStoriesRepository {

    override var topStories: Observable<List<Story>> = when {
        error != null -> Observable.error(error)
        else -> Observable.just(stories)
    }
}