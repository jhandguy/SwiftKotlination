package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.app.Application
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryManager
import fr.jhandguy.swiftkotlination.features.story.model.StoryManagerInterface
import fr.jhandguy.swiftkotlination.features.story.view.StoryView
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManager
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesManagerInterface
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesAdapter
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesView
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.network.NetworkManager
import fr.jhandguy.swiftkotlination.network.NetworkManagerInterface
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.koin.android.ext.android.startKoin
import org.koin.dsl.module.Module
import org.koin.dsl.module.module

open class App: Application() {

    private val navigationModule: Module = module {
        factory { (activity: Activity) -> CoordinatorImpl(activity) as Coordinator }
    }

    private val topStoriesModule: Module = module("top-stories") {
        single { NetworkManager() as NetworkManagerInterface }
        factory { TopStoriesManager(get()) as TopStoriesManagerInterface }
        factory { TopStoriesViewModel(get()) }
        factory { TopStoriesAdapter(get { it } ) }
        factory { TopStoriesView(get { it }, get { it } ) }
    }

    private val storyModule: Module = module("story") {
        factory { (story: Story) -> StoryManager(story) as StoryManagerInterface }
        factory { StoryViewModel(get { it } ) }
        factory { StoryView(get { it } ) }
    }

    override fun onCreate() {
        super.onCreate()
        startKoin(this, listOf(navigationModule, topStoriesModule, storyModule))
    }
}

fun launch(block: suspend CoroutineScope.() -> Unit) {
    CoroutineScope(Dispatchers.Default).launch(block = block)
}