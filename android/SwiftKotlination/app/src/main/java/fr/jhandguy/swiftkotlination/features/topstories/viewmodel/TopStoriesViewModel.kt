package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable

class TopStoriesViewModel(repository: TopStoriesRepository) {
    var topStories: Observable<List<Story>> = repository.topStories.map { it.results }
}