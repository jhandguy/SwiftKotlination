package fr.jhandguy.swiftkotlination.features.story.viewmodel

import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import io.reactivex.Observable

class StoryRepositoryMock(override var story: Observable<Story>) : StoryRepository