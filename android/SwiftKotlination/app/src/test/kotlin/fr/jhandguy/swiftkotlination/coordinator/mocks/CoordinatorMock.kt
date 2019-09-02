package fr.jhandguy.swiftkotlination.coordinator.mocks

import android.content.Intent
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.model.Story

class CoordinatorMock : CoordinatorInterface {
    var isStarted = false
    var isStoryOpen = false
    var isUrlOpen = false
    var isFinished = false

    override fun start(): Intent {
        isStarted = true
        return Intent()
    }

    override fun open(story: Story): Intent {
        isStoryOpen = true
        return Intent()
    }

    override fun open(url: String): Intent {
        isUrlOpen = true
        return Intent()
    }

    override fun finish() {
        isFinished = true
    }
}
