package fr.jhandguy.swiftkotlination.factory

import androidx.test.core.app.ActivityScenario
import fr.jhandguy.network.model.network.NetworkManager
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.StoryManager
import fr.jhandguy.swiftkotlination.coordinator.Coordinator
import fr.jhandguy.swiftkotlination.view.MainActivity
import fr.jhandguy.topstories.model.TopStoriesManager
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import kotlin.test.BeforeTest
import kotlin.test.Test

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
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
        assert(manager is fr.jhandguy.image.model.ImageManager)
    }

    @Test
    fun `story manager is made correctly`() {
        val story = Story()
        val manager = sut.makeStoryManager(story)
        assert(manager is StoryManager)
    }
}
