package fr.jhandguy.swiftkotlination.features.topstories.model

import io.reactivex.Observable
import java.util.*

interface TopStoriesRepository {
    var topStories: Observable<MutableList<Story>>
}

class TopStoriesRepositoryImpl: TopStoriesRepository {
    override var topStories: Observable<MutableList<Story>> = Observable.just(
        Collections.singletonList(Story("section","subsection","title", "abstract","url","byline"))
    )
}