package fr.jhandguy.topstories.viewmodel

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.model.Story
import fr.jhandguy.topstories.factory.TopStoriesFactory

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
        return null
    } ?: imageManager.image(url) { result ->
        when (result) {
            is Result.Success -> {
                val image = BitmapFactory.decodeByteArray(result.data, 0, result.data.size)
                images[url] = image
                observer(Result.Success(image))
            }
            is Result.Failure -> observer(result)
        }
    }
}
