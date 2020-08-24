package fr.jhandguy.story.factory

import android.app.Activity
import fr.jhandguy.image.factory.ImageFactory
import fr.jhandguy.story.coordinator.StoryCoordinatorInterface
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManagerInterface
import fr.jhandguy.story.viewmodel.StoryViewModel

interface StoryFactory : ImageFactory {
    fun makeStoryManager(story: Story): StoryManagerInterface
    fun makeStoryViewModel(story: Story): StoryViewModel
    fun makeStoryCoordinator(activity: Activity): StoryCoordinatorInterface
}
