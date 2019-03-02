package fr.jhandguy.swiftkotlination.features.topstories.view

import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import androidx.test.core.app.ActivityScenario
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.coordinator.mocks.CoordinatorMock
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.swiftkotlination.features.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.model.mocks.ImageManagerMock
import fr.jhandguy.swiftkotlination.network.NetworkError
import fr.jhandguy.swiftkotlination.observer.Result
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
class TopStoriesViewUnitTest {

    lateinit var sut: TopStoriesView

    @Test
    fun `views are created correctly`() {
        val scenario = ActivityScenario.launch(MainActivity::class.java)
        scenario.onActivity {
            val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
            val factory = TopStoriesFactoryMock(topStoriesManager, imageManager)
            val viewModel = TopStoriesViewModel(factory)
            val coordinator = CoordinatorMock()
            val adapter = TopStoriesAdapter(it, viewModel, coordinator)
            sut = TopStoriesView(adapter, viewModel)

            val context = AnkoContext.create(it)
            val view = sut.createView(context)

            view.find<RecyclerView>(R.id.top_stories_list).run {
                assert(layoutManager is LinearLayoutManager)
                assertEquals(this.adapter, adapter)
            }

            assert(view is SwipeRefreshLayout)
        }
    }
}