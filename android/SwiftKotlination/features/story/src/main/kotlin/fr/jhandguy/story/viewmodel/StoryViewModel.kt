package fr.jhandguy.story.viewmodel

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import fr.jhandguy.network.model.observer.Disposable
import fr.jhandguy.network.model.observer.Observer
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.factory.StoryFactory
import fr.jhandguy.story.model.Story

class StoryViewModel(factory: StoryFactory, story: Story = Story(), var image: Bitmap? = null) {
    private val storyManager = factory.makeStoryManager(story)
    private val imageManager = factory.makeImageManager()

    suspend fun story(observer: Observer<Story>) = storyManager.story(observer)

    suspend fun image(url: String, observer: Observer<Bitmap>): Disposable? = image?.let { image ->
        observer(Result.Success(image))
        return null
    } ?: imageManager.image(url) { result ->
        when (result) {
            is Result.Success -> {
                val image = BitmapFactory.decodeByteArray(result.data, 0, result.data.size)
                this.image = image
                observer(Result.Success(image))
            }
            is Result.Failure -> observer(result)
        }
    }
}
