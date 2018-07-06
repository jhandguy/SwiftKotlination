package fr.jhandguy.swiftkotlination

import android.app.Application
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
import org.koin.dsl.module.applicationContext
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory

open class App: Application() {

    private val navigationModule: Module = applicationContext {
        factory { CoordinatorImpl(it["activity"]) as Coordinator }
    }

    private val topStoriesModule: Module = applicationContext {
        context("top-stories") {
            bean {
                Retrofit
                        .Builder()
                        .baseUrl("https://api.nytimes.com")
                        .addConverterFactory(MoshiConverterFactory.create())
                        .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                        .build()
                        .create(TopStoriesService::class.java)
                        as TopStoriesService
            }
            factory { TopStoriesRepositoryImpl(get()) as TopStoriesRepository }
            factory { TopStoriesViewModel(get()) }
            factory { TopStoriesAdapter(get { it.values }) }
            factory { TopStoriesView(get{ it.values }) }
        }
    }

    private val storyModule: Module = applicationContext {
        context("story") {
            factory { StoryRepositoryImpl(it["story"]) as StoryRepository }
            factory { StoryViewModel(get{ it.values }) }
            factory { StoryView(coordinator = get{ it.values }) }
        }
    }

    override fun onCreate() {
        super.onCreate()
        startKoin(this, listOf(navigationModule, topStoriesModule, storyModule))
    }
}