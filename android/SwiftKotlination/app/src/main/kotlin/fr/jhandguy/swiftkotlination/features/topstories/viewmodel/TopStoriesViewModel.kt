package fr.jhandguy.swiftkotlination.features.topstories.viewmodel

import android.graphics.Bitmap
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

class TopStoriesViewModel(factory: TopStoriesFactory) {
    private val topStoriesManager = factory.makeTopStoriesManager()
    private val imageManager = factory.makeImageManager()

    var stories: List<Story> = emptyList()
    var images: MutableMap<String, Bitmap> = HashMap()

    suspend fun topStories(observer: Observer<List<Story>>) = topStoriesManager.topStories { result ->
        when (result) {
            is Result.Success -> {
                stories = result.data.results
                observer(Result.Success(stories))
            }
            is Result.Failure -> observer(result)
        }
    }

    suspend fun refresh() = topStoriesManager.fetchStories()

    suspend fun image(url: String, observer: Observer<Bitmap>): Disposable? = images[url]?.let { image ->
            observer(Result.Success(image))
            null
        } ?: imageManager.image(url) { result ->
            when (result) {
                is Result.Success -> {
                    images[url] = result.data
                    observer(result)
                }
                is Result.Failure -> observer(result)
            }
        }
}