package fr.jhandguy.story.coordinator.mocks

import android.content.Intent
import fr.jhandguy.story.coordinator.StoryCoordinatorInterface

class StoryCoordinatorMock : StoryCoordinatorInterface {
    var isUrlOpen = false
    var isFinished = false

    override fun open(url: String): Intent {
        isUrlOpen = true
        return Intent()
    }

    override fun finish() {
        isFinished = true
    }
}
