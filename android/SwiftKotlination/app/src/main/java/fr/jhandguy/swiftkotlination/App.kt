package fr.jhandguy.swiftkotlination

import android.app.Activity
import android.app.Application
import android.content.Context
import dagger.BindsInstance
import dagger.Component
import dagger.android.DispatchingAndroidInjector
import dagger.android.HasActivityInjector
import dagger.android.support.AndroidSupportInjectionModule
import fr.jhandguy.swiftkotlination.di.ActivityModule
import fr.jhandguy.swiftkotlination.di.NavigationModule
import javax.inject.Inject
import javax.inject.Singleton

open class App: Application(), HasActivityInjector {
    @Inject
    protected lateinit var dispatchingAndroidInjector: DispatchingAndroidInjector<Activity>
    override fun activityInjector() = dispatchingAndroidInjector

    override fun onCreate() {
        super.onCreate()
        DaggerApp_AppComponent.builder()
                .app(this)
                .build()
                .inject(this)
    }

    @Singleton
    @Component(modules = [
        AndroidSupportInjectionModule::class,
        ActivityModule::class,
        NavigationModule::class
    ])
    interface AppComponent {
        fun inject(app: App)

        @Component.Builder
        interface Builder {
            fun build(): AppComponent
            @BindsInstance
            fun app(app: Context): Builder
        }
    }
}