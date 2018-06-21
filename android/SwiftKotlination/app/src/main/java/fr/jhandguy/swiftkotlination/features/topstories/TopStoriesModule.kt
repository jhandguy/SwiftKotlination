package fr.jhandguy.swiftkotlination.features.topstories

import dagger.Module
import dagger.android.ContributesAndroidInjector
import fr.jhandguy.swiftkotlination.ActivityScoped
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivityModule

@Module
abstract class TopStoriesModule {
    @ActivityScoped
    @ContributesAndroidInjector(modules = [TopStoriesActivityModule::class])
    abstract fun topStoriesActivity(): TopStoriesActivity
}