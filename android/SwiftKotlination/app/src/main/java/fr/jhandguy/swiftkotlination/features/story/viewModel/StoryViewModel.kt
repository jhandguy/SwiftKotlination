package fr.jhandguy.swiftkotlination.features.story.viewModel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import io.reactivex.Observable
import javax.inject.Inject

class StoryViewModel @Inject constructor(repository: StoryRepository) {
    var story: Observable<Story> = repository.story
}