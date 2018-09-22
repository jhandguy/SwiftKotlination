package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.content.Intent
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.core.parameter.parametersOf
import org.koin.standalone.StandAloneContext.stopKoin
import org.koin.standalone.inject
import org.koin.test.KoinTest
import org.robolectric.Robolectric.buildActivity
import org.robolectric.RobolectricTestRunner
import org.robolectric.android.controller.ActivityController


@RunWith(RobolectricTestRunner::class)
class CoordinatorUnitTest: KoinTest {

    lateinit var activityController: ActivityController<Activity>

    val coordinator: Coordinator by inject { parametersOf(activityController.get()) }

    @Before
    fun before() {
        activityController = buildActivity(Activity::class.java)
    }

    @Test
    fun `coordinator starts correctly`() {
        val intent = coordinator.start()

        assert(activityController.get().isFinishing)
        assertEquals(intent.component.className, TopStoriesActivity::class.java.name)
    }

    @Test
    fun `coordinator opens story correctly`() {
        val intent = coordinator.open(Story())

        assert(!activityController.get().isFinishing)
        assertEquals(intent.component.className, StoryActivity::class.java.name)
    }

    @Test
    fun `coordinator opens url correctly`() {
        val url = "https//test.com"
        val intent = coordinator.open(url)

        assert(!activityController.get().isFinishing)
        assertEquals(intent.action, Intent.ACTION_VIEW)
        assertEquals(intent.dataString, url)
    }

    @Test
    fun `coordinator finishes correctly`() {
        coordinator.finish()

        assert(activityController.get().isFinishing)
    }

    @After
    fun after() {
        stopKoin()
    }
}