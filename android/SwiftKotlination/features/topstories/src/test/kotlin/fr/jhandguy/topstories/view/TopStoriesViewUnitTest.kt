package fr.jhandguy.topstories.view

import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import androidx.test.core.app.ActivityScenario
import androidx.test.core.app.ApplicationProvider
import fr.jhandguy.network.model.network.NetworkError
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.test.image.mocks.ImageManagerMock
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.application.TopStoriesApp
import fr.jhandguy.topstories.coordinator.mocks.TopStoriesCoordinatorMock
import fr.jhandguy.topstories.factory.mocks.TopStoriesFactoryMock
import fr.jhandguy.topstories.model.mocks.TopStoriesManagerMock
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config
import org.robolectric.annotation.LooperMode
import org.robolectric.annotation.LooperMode.Mode.PAUSED
import kotlin.test.Test
import kotlin.test.assertEquals

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [28])
@LooperMode(PAUSED)
class TopStoriesViewUnitTest {

    lateinit var sut: TopStoriesView

    @Test
    fun `views are created correctly`() {
        val topStoriesManager = TopStoriesManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val imageManager = ImageManagerMock(Result.Failure(NetworkError.InvalidResponse()))
        val coordinator = TopStoriesCoordinatorMock()
        val factory = TopStoriesFactoryMock(topStoriesManager, imageManager, coordinator)
        val application = ApplicationProvider.getApplicationContext<TopStoriesApp>()
        application.factory = factory

        val scenario = ActivityScenario.launch(TopStoriesActivity::class.java)
        scenario.onActivity {
            val viewModel = TopStoriesViewModel(factory)
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
