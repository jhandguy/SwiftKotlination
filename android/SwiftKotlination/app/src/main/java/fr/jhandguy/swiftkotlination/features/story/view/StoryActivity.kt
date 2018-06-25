package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.CoordinatorImpl
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepository
import fr.jhandguy.swiftkotlination.features.story.model.StoryRepositoryImpl
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import org.jetbrains.anko.setContentView
import javax.inject.Inject

@Module
object StoryActivityModule {

    @Provides
    @JvmStatic
    fun provideCoordinator(activity: StoryActivity): Coordinator = CoordinatorImpl(activity)

    @Provides
    @JvmStatic
    fun provideStory(storyActivity: StoryActivity): Story = storyActivity.intent.extras.getSerializable(Story::class.java.simpleName) as? Story ?: Story()

    @Provides
    @JvmStatic
    fun provideRepository(story: Story): StoryRepository = StoryRepositoryImpl(story)

    @Provides
    @JvmStatic
    fun provideViewModel(repository: StoryRepository) = StoryViewModel(repository)

    @Provides
    @JvmStatic
    fun provideView(story: Story, coordinator: Coordinator) = StoryView(story, coordinator)
}

class StoryActivity: AppCompatActivity() {
    @Inject
    lateinit var coordinator: Coordinator

    @Inject
    lateinit var viewModel: StoryViewModel

    @Inject
    lateinit var view: StoryView

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)

        view.setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        viewModel
                .story
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe {
                    title = arrayOf(it.section, it.subsection)
                            .filter { it.isNotEmpty() }
                            .joinToString(separator = " - ")
                }
    }

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }
}