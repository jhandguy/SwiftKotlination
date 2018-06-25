package fr.jhandguy.swiftkotlination.features.story

import dagger.Module
import dagger.android.ContributesAndroidInjector
import fr.jhandguy.swiftkotlination.ActivityScoped
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivity
import fr.jhandguy.swiftkotlination.features.story.view.StoryActivityModule

@Module
abstract class StoryModule {
    @ActivityScoped
    @ContributesAndroidInjector(modules = [StoryActivityModule::class])
    abstract fun storyActivity(): StoryActivity
}