package fr.jhandguy.swiftkotlination.features.main.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import fr.jhandguy.swiftkotlination.navigation.Navigator
import fr.jhandguy.swiftkotlination.features.main.viewmodel.MainViewModel
import javax.inject.Inject

@Module
object MainActivityModule {
    @Provides
    @JvmStatic
    fun provideViewModel(coordinator: Coordinator) = MainViewModel(coordinator)
}

class MainActivity: AppCompatActivity() {

    @Inject
    lateinit var navigator: Navigator

    @Inject
    lateinit var viewModel: MainViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        navigator.activity = this
    }

    override fun onStart() {
        super.onStart()
        viewModel.start()
    }

    override fun onDestroy() {
        navigator.activity = null
        super.onDestroy()
    }
}