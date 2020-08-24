package fr.jhandguy.topstories.coordinator.mocks

import android.content.Intent
import fr.jhandguy.story.model.Story
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface

class TopStoriesCoordinatorMock : TopStoriesCoordinatorInterface {
    var isStoryOpen = false

    override fun open(story: Story): Intent {
        isStoryOpen = true
        return Intent()
    }
}
