package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import io.reactivex.Observable
import javax.inject.Inject

class TopStoriesViewModel @Inject constructor(val coordinator: Coordinator, repository: TopStoriesRepository) {
    var topStories: Observable<List<Story>> = repository.topStories

    fun open(story: Story) {
        coordinator.open(story)
    }
}