package fr.jhandguy.swiftkotlination.features.story

import androidx.test.rule.ActivityTestRule
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import org.junit.Rule
import org.junit.Test

class StoryActivityTest {
    @get:Rule
    val activityRule = ActivityTestRule(StoryActivity::class.java, false, false)

    @Test
    fun `test`() {}
}