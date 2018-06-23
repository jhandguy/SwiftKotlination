package fr.jhandguy.swiftkotlination.features.topstories.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepository
import fr.jhandguy.swiftkotlination.features.topstories.model.TopStoriesRepositoryImpl
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import fr.jhandguy.swiftkotlination.navigation.Navigator
import org.jetbrains.anko.setContentView
import javax.inject.Inject

@Module
object TopStoriesActivityModule {
    @Provides
    @JvmStatic
    fun provideRepository(): TopStoriesRepository = TopStoriesRepositoryImpl()

    @Provides
    @JvmStatic
    fun provideViewModel(coordinator: Coordinator, repository: TopStoriesRepository) = TopStoriesViewModel(coordinator, repository)

    @Provides
    @JvmStatic
    fun provideAdapter(viewModel: TopStoriesViewModel) = TopStoriesAdapter(onClickCallback = { viewModel.open(it) })
}

class TopStoriesActivity: AppCompatActivity() {

    @Inject
    lateinit var navigator: Navigator

    @Inject
    lateinit var viewModel: TopStoriesViewModel

    @Inject
    lateinit var adapter: TopStoriesAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        TopStoriesView(adapter).setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        navigator.activity = this

        viewModel
                .topStories
                .subscribe {
                    adapter.topStories = it
                    adapter.notifyDataSetChanged()
                }
    }
}