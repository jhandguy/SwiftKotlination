package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.features.story.model.Story
import io.reactivex.Observable

interface TopStoriesRepository {
    var topStories: Observable<List<Story>>
}

class TopStoriesRepositoryImpl(topStoriesService: TopStoriesService): TopStoriesRepository {
    override var topStories: Observable<List<Story>> = topStoriesService.getObservable().map { it.results }
}