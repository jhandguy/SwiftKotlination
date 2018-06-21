package fr.jhandguy.swiftkotlination.features.main

import dagger.Module
import dagger.android.ContributesAndroidInjector
import fr.jhandguy.swiftkotlination.ActivityScoped
import fr.jhandguy.swiftkotlination.features.main.view.MainActivity
import fr.jhandguy.swiftkotlination.features.main.view.MainActivityModule

@Module
abstract class MainModule {
    @ActivityScoped
    @ContributesAndroidInjector(modules = [MainActivityModule::class])
    abstract fun mainActivity(): MainActivity
}