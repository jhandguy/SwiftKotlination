package fr.jhandguy.swiftkotlination.features.topstories.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.CoordinatorImpl
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepositoryImpl
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesService
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.schedulers.Schedulers
import org.jetbrains.anko.setContentView
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.moshi.MoshiConverterFactory
import javax.inject.Inject

@Module
object TopStoriesActivityModule {
    @Provides
    @JvmStatic
    fun provideCoordinator(activity: TopStoriesActivity): Coordinator = CoordinatorImpl(activity)

    @Provides
    @JvmStatic
    fun provideService(): TopStoriesService = Retrofit
            .Builder()
            .baseUrl("https://api.nytimes.com")
            .addConverterFactory(MoshiConverterFactory.create())
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .build()
            .create(TopStoriesService::class.java)

    @Provides
    @JvmStatic
    fun provideRepository(service: TopStoriesService): TopStoriesRepository = TopStoriesRepositoryImpl(service)

    @Provides
    @JvmStatic
    fun provideViewModel(repository: TopStoriesRepository) = TopStoriesViewModel(repository)

    @Provides
    @JvmStatic
    fun provideAdapter(coordinator: Coordinator) = TopStoriesAdapter(coordinator)

    @Provides
    @JvmStatic
    fun provideView(adapter: TopStoriesAdapter) = TopStoriesView(adapter)
}

class TopStoriesActivity: AppCompatActivity() {

    @Inject
    lateinit var viewModel: TopStoriesViewModel

    @Inject
    lateinit var view: TopStoriesView

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        view.setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        viewModel
                .topStories
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeBy(
                    onNext = {
                        view.adapter.topStories = it
                        view.adapter.notifyDataSetChanged()
                    },
                    onError = {
                        print(it.message)
                    }
                )
    }
}