package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.content.Intent
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import org.junit.Assert.assertEquals
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.core.parameter.parametersOf
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.robolectric.Robolectric.setupActivity
import org.robolectric.RobolectricTestRunner


@RunWith(RobolectricTestRunner::class)
class CoordinatorUnitTest: KoinTest {

    lateinit var activity: Activity

    val coordinator: Coordinator by inject { parametersOf(activity) }

    @Before
    fun before() {
        activity = setupActivity(Activity::class.java)
    }

    @Test
    fun `coordinator starts correctly`() {
        val intent = coordinator.start()

        assert(activity.isFinishing)
        assertEquals(intent.component.className, TopStoriesActivity::class.java.name)
    }

    @Test
    fun `coordinator opens story correctly`() {
        val intent = coordinator.open(Story())

        assert(!activity.isFinishing)
        assertEquals(intent.component.className, StoryActivity::class.java.name)
    }

    @Test
    fun `coordinator opens url correctly`() {
        val url = "https//test.com"
        val intent = coordinator.open(url)

        assert(!activity.isFinishing)
        assertEquals(intent.action, Intent.ACTION_VIEW)
        assertEquals(intent.dataString, url)
    }

    @Test
    fun `coordinator finishes correctly`() {
        coordinator.finish()

        assert(activity.isFinishing)
    }

    @After
    fun after() {
        closeKoin()
    }
}