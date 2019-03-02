package fr.jhandguy.swiftkotlination.factory

import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManager
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManager
import fr.jhandguy.swiftkotlination.model.ImageManager
import fr.jhandguy.swiftkotlination.network.NetworkManager
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.BeforeTest
import kotlin.test.Test

@RunWith(RobolectricTestRunner::class)
class DependencyManagerUnitTest {

    lateinit var sut: DependencyManager

    @BeforeTest
    fun setup() {
        sut = DependencyManager(NetworkManager())
    }

    @Test
    fun `coordinator is made correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            val coordinator = sut.makeCoordinator(it)
            assert(coordinator is Coordinator)
        }
    }

    @Test
    fun `top stories manager is made correctly`() {
        val manager = sut.makeTopStoriesManager()
        assert(manager is TopStoriesManager)
    }

    @Test
    fun `image manager is made correctly`() {
        val manager = sut.makeImageManager()
        assert(manager is ImageManager)
    }

    @Test
    fun `story manager is made correctly`() {
        val story = Story()
        val manager = sut.makeStoryManager(story)
        assert(manager is StoryManager)
    }
}