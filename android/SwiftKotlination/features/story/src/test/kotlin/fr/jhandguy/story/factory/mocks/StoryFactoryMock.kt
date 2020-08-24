package fr.jhandguy.story.factory.mocks

import android.app.Activity
import fr.jhandguy.image.model.ImageManagerInterface
import fr.jhandguy.story.coordinator.StoryCoordinatorInterface
import fr.jhandguy.story.factory.StoryFactory
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManagerInterface
import fr.jhandguy.story.viewmodel.StoryViewModel

class StoryFactoryMock(
    val storyManager: StoryManagerInterface,
    val imageManager: ImageManagerInterface,
    val storyCoordinator: StoryCoordinatorInterface
) : StoryFactory {
    override fun makeStoryManager(story: Story): StoryManagerInterface = storyManager
    override fun makeStoryViewModel(story: Story): StoryViewModel = StoryViewModel(this, story)
    override fun makeStoryCoordinator(activity: Activity): StoryCoordinatorInterface = storyCoordinator
    override fun makeImageManager(): ImageManagerInterface = imageManager
}
