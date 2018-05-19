package fr.jhandguy.swiftkotlination.di

import dagger.Module
import dagger.android.ContributesAndroidInjector
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.main.view.MainActivityModule
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivity
import fr.jhandguy.swiftkotlination.features.topstories.view.TopStoriesActivityModule

@Module
abstract class ActivityModule {
    @ActivityScoped
    @ContributesAndroidInjector(modules = [MainActivityModule::class])
    abstract fun mainActivity(): MainActivity

    @ActivityScoped
    @ContributesAndroidInjector(modules = [TopStoriesActivityModule::class])
    abstract fun topStoriesActivity(): TopStoriesActivity
}