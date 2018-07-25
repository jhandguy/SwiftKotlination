package fr.jhandguy.swiftkotlination.features.topstories.model

import io.reactivex.Observable

class TopStoriesServiceMock(val topStories: TopStories = TopStories(ArrayList()), val error: Error? = null): TopStoriesService {

    override fun getObservable(apiKey: String): Observable<TopStories> = when {
        error != null -> Observable.error(error)
        else -> Observable.just(topStories)
    }
}