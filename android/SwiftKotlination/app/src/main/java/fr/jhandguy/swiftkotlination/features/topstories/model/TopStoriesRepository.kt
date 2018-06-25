package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.features.story.model.Story
import io.reactivex.Observable
import javax.inject.Inject

interface TopStoriesRepository {
    var topStories: Observable<List<Story>>
}

class TopStoriesRepositoryImpl @Inject constructor(topStoriesService: TopStoriesService): TopStoriesRepository {
    override var topStories: Observable<List<Story>> = topStoriesService.getObservable().map { it.results }
}