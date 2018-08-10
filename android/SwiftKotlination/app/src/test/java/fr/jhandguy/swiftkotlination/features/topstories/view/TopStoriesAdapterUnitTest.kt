package fr.jhandguy.swiftkotlination.features.topstories.view

import android.app.Activity
import android.widget.Button
import android.widget.TextView
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.AnkoContext.Companion.create
import org.jetbrains.anko.find
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.koin.standalone.StandAloneContext.closeKoin
import org.mockito.Mock
import org.mockito.MockitoAnnotations.initMocks
import org.robolectric.Robolectric.setupActivity
import org.robolectric.RobolectricTestRunner

@RunWith(RobolectricTestRunner::class)
class TopStoriesAdapterUnitTest {

    lateinit var adapter: TopStoriesAdapter

    lateinit var viewHolder: TopStoriesAdapter.ViewHolder

    val topStories: List<Story> = listOf(
            Story("section1","subsection1","title1","abstract1","https://url.com1","byline1") ,
            Story("section2","subsection2","title2","abstract2","https://url.com2","byline2")
    )

    @Mock
    lateinit var coordinator: Coordinator

    @Before
    fun before() {
        initMocks(this)
        adapter = TopStoriesAdapter(coordinator, topStories)
        viewHolder = TopStoriesAdapter.ViewHolder(TopStoriesItemView().createView(create(setupActivity(Activity::class.java))), coordinator)
    }

    @Test
    fun `adapter contains top stories`() {
        assertEquals(adapter.itemCount, topStories.size)

        topStories.forEachIndexed { index, story ->

            adapter.bindViewHolder(viewHolder, index)

            with(viewHolder.itemView) {
                with(find<TextView>(R.id.top_stories_item_title)) {
                    assertEquals(text, story.title)
                }

                with(find<TextView>(R.id.top_stories_item_byline)) {
                    assertEquals(text, story.byline)
                }

                with(find<Button>(R.id.top_stories_item_button)) {
                    assertEquals(text, resources.getString(R.string.top_stories_button_title))
                }
            }
        }
    }

    @After
    fun after() {
        closeKoin()
    }
}