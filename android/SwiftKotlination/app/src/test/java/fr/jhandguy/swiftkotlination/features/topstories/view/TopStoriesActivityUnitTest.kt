package fr.jhandguy.swiftkotlination.features.topstories.view

import android.support.v7.widget.RecyclerView
import android.widget.Button
import android.widget.TextView
import com.nhaarman.mockito_kotlin.whenever
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import io.reactivex.Observable
import org.jetbrains.anko.childrenSequence
import org.jetbrains.anko.contentView
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.test.KoinTest
import org.koin.test.declare
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.buildActivity
import org.robolectric.RobolectricTestRunner
import org.robolectric.android.controller.ActivityController

@RunWith(RobolectricTestRunner::class)
class TopStoriesActivityUnitTest: KoinTest {

    lateinit var activityController: ActivityController<TopStoriesActivity>

    val topStories: List<Story> = listOf(
            Story("section1","subsection1","title1","abstract1","https://url.com1","byline1") ,
            Story("section2","subsection2","title2","abstract2","https://url.com2","byline2")
    )

    @Mock
    lateinit var repository: TopStoriesRepository

    @Before
    fun before() {
        initMocks(this)
        declare("top-stories") {
            factory(override = true) { repository }
        }
        activityController = buildActivity(TopStoriesActivity::class.java)
        whenever(repository.topStories).thenReturn(Observable.just(topStories))
    }

    @Test
    fun `top stories activity starts`() {
        with(activityController.get()) {
            assertEquals(title, "SwiftKotlination")
            assertNull(contentView)
        }

        with(activityController.create().get()) {
            contentView?.let { contentView ->

                with(contentView.find<RecyclerView>(R.id.top_stories_list)) {

                    assertNotNull(this)

                    childrenSequence().forEach {

                        with(it) {
                            assertNotNull(find<TextView>(R.id.top_stories_item_title))
                            assertNotNull(find<TextView>(R.id.top_stories_item_byline))
                            assertNotNull(find<Button>(R.id.top_stories_item_button))
                        }
                    }
                }
            } ?: fail("ContentView should not be null")

            assertEquals(title, "Top Stories")
            assertNotEquals(view.adapter.topStories, topStories)
        }

        with(activityController.start().get()) {
            assertEquals(view.adapter.topStories, topStories)
        }
    }

    @After
    fun after() {
        closeKoin()
    }
}