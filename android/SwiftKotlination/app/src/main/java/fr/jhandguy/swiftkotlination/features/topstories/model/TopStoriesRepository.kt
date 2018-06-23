package fr.jhandguy.swiftkotlination.features.topstories.model

import io.reactivex.Observable
import java.util.*

interface TopStoriesRepository {
    var topStories: Observable<MutableList<Story>>
}

class TopStoriesRepositoryImpl: TopStoriesRepository {
    override var topStories: Observable<MutableList<Story>> = Observable.just(
        Collections.singletonList(Story("U.S.","Politics","Trump Highlights Immigrant Crime to Defend His Border Policy. Statistics Don't Back Him Up.", "The president's remarks, delivered with relatives of those killed by undocumented immigrants, came two days after he signed an executive order to keep together families detained at the border.","url","By KATIE ROGERS"))
    )
}