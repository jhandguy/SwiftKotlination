package fr.jhandguy.swiftkotlination.di

import dagger.Module
import dagger.Provides
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import fr.jhandguy.swiftkotlination.navigation.CoordinatorImpl
import fr.jhandguy.swiftkotlination.navigation.Navigator
import fr.jhandguy.swiftkotlination.navigation.NavigatorImpl
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