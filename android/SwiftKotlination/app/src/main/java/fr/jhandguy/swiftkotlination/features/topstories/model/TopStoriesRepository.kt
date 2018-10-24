package fr.jhandguy.swiftkotlination.features.topstories.model

import io.reactivex.Observable

interface TopStoriesRepository {
    var topStories: Observable<TopStories>
}

class TopStoriesRepositoryImpl(topStoriesService: TopStoriesService): TopStoriesRepository {
    override var topStories: Observable<TopStories> = topStoriesService.getObservable().map { it }
}