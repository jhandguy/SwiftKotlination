package fr.jhandguy.swiftkotlination.features.topstories.view

import android.graphics.Color
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import dagger.Module
import dagger.Provides
import dagger.android.AndroidInjection
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.navigation.Coordinator
import org.jetbrains.anko.textColor
import org.jetbrains.anko.textView
import org.jetbrains.anko.verticalLayout
import javax.inject.Inject

@Module
object TopStoriesActivityModule {
    @Provides
    @JvmStatic
    fun provideViewModel(coordinator: Coordinator) = TopStoriesViewModel(coordinator)
}

class TopStoriesActivity: AppCompatActivity() {

    @Inject
    lateinit var viewModel: TopStoriesViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        AndroidInjection.inject(this)
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        verticalLayout {
            textView("Title") {
                textColor = Color.WHITE
            }
            textView("Description") {
                textColor = Color.WHITE
            }
        }
    }
}