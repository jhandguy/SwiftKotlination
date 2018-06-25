package fr.jhandguy.swiftkotlination.features.main.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.CoordinatorImpl
import javax.inject.Inject

@Module
object MainActivityModule {
    @Provides
    @JvmStatic
    fun provideCoordinator(activity: MainActivity): Coordinator = CoordinatorImpl(activity)
}

class MainActivity: AppCompatActivity() {

    @Inject
    lateinit var coordinator: Coordinator

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)
    }

    override fun onStart() {
        super.onStart()
        coordinator.start()
    }
}