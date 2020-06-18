package fr.jhandguy.swiftkotlination.features.story.viewModel

import android.graphics.Bitmap
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.observer.Disposable
import fr.jhandguy.swiftkotlination.observer.Observer
import fr.jhandguy.swiftkotlination.observer.Result

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
                image = result.data
                observer(result)
            }
            is Result.Failure -> observer(result)
        }
    }
}
