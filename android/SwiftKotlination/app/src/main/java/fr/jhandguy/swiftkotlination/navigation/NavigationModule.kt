package fr.jhandguy.swiftkotlination.navigation

import dagger.Module
import dagger.Provides
import javax.inject.Singleton

@Module
class NavigationModule {
    @Provides
    @Singleton
    fun provideNavigator(): Navigator = NavigatorImpl()

    @Provides
    @Singleton
    fun provideCoordinator(navigator: Navigator): Coordinator = CoordinatorImpl(navigator)
}