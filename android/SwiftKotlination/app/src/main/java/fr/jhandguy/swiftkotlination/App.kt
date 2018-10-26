package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.app.Application
import com.jakewharton.retrofit2.adapter.kotlin.coroutines.experimental.CoroutineCallAdapterFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepositoryImpl
import fr.jhandguy.swiftkotlination.features.story.view.StoryView
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepositoryImpl
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesService
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesAdapter
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesView
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import org.koin.android.ext.android.startKoin
import org.koin.dsl.module.Module
import org.koin.dsl.module.module
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

open class App: Application() {

    private val navigationModule: Module = module {
        factory { (activity: Activity) -> CoordinatorImpl(activity) as Coordinator }
    }

    private val topStoriesModule: Module = module("top-stories") {
        single {
            Retrofit
                    .Builder()
                    .baseUrl("https://api.nytimes.com")
                    .addCallAdapterFactory(CoroutineCallAdapterFactory())
                    .addConverterFactory(MoshiConverterFactory.create())
                    .build()
                    .create(TopStoriesService::class.java)
                    as TopStoriesService
        }
        factory { TopStoriesRepositoryImpl(get()) as TopStoriesRepository }
        factory { TopStoriesViewModel(get()) }
        factory { TopStoriesAdapter(get { it } ) }
        factory { TopStoriesView(get { it } ) }
    }

    private val storyModule: Module = module("story") {
        factory { (story: Story) -> StoryRepositoryImpl(story) as StoryRepository }
        factory { StoryViewModel(get { it } ) }
        factory { StoryView(get { it } ) }
    }

    override fun onCreate() {
        super.onCreate()
        startKoin(this, listOf(navigationModule, topStoriesModule, storyModule))
    }
}