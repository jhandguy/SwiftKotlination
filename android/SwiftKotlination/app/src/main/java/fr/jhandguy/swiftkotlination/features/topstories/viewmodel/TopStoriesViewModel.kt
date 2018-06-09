package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import fr.jhandguy.swiftkotlination.features.topstories.model.Story
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import io.reactivex.Observable
import java.util.*
import javax.inject.Inject

class TopStoriesViewModel @Inject constructor(val coordinator: Coordinator) {
    var topStories = Observable.just(
        Collections.singletonList(Story("section","subsection","title", "abstract","url","byline"))
    )
}