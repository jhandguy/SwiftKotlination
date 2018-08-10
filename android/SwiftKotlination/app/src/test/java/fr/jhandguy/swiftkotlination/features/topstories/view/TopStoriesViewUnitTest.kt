package fr.jhandguy.swiftkotlination.features.topstories.view

import android.app.Activity
import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.Button
import android.widget.RelativeLayout
import com.nhaarman.mockito_kotlin.verify
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.childrenSequence
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.koin.test.KoinTest
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.buildActivity
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class TopStoriesViewUnitTest: KoinTest {

    lateinit var view: View

    val topStories: List<Story> = listOf(
            Story("section1","subsection1","title1","abstract1","https://url.com1","byline1") ,
            Story("section2","subsection2","title2","abstract2","https://url.com2","byline2")
    )

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        view = TopStoriesView(TopStoriesAdapter(coordinator, topStories))
                .createView(AnkoContext.create(buildActivity(Activity::class.java).get()))
    }

    @Test
    fun `top stories view is created`() {
        with(view) {
            assert(this is RelativeLayout)
            assertEquals(childrenSequence().count(), 1)

            with(find<RecyclerView>(R.id.top_stories_list)) {
                assertNotNull(this)
                layout(0,0,100,1000)
                assertEquals(childCount, topStories.size)
            }
        }
    }

    @Test
    fun `coordinator opens story`() {
        with(view.find<RecyclerView>(R.id.top_stories_list)) {
            layout(0,0,100,1000)
            with(getChildAt(1).find<Button>(R.id.top_stories_item_button)) {
                assert(callOnClick())
            }
        }

        verify(coordinator).open(topStories[1])
    }

    @After
    fun after() {
        closeKoin()
    }
}