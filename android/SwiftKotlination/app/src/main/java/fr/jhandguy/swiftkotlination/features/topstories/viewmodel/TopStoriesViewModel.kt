package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable
import javax.inject.Inject

class TopStoriesViewModel @Inject constructor(repository: TopStoriesRepository) {
    var topStories: Observable<List<Story>> = repository.topStories
}