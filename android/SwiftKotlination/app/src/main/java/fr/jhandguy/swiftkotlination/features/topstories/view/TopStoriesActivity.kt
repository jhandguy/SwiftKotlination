package fr.jhandguy.swiftkotlination.features.topstories.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.network.Result
import kotlinx.coroutines.experimental.android.UI
import kotlinx.coroutines.experimental.async
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.scope.ext.android.bindScope
import org.koin.android.scope.ext.android.getOrCreateScope
import org.koin.core.parameter.parametersOf

class TopStoriesActivity: AppCompatActivity() {

    val viewModel: TopStoriesViewModel by inject()

    val view: TopStoriesView by inject { parametersOf(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        bindScope(getOrCreateScope("top-stories"))

        title = "Top Stories"

        view.setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        async(UI) {
            viewModel.topStories { result ->
                when (result) {
                    is Result.Success -> {
                        view.adapter.topStories = result.data
                        view.adapter.notifyDataSetChanged()
                    }
                    is Result.Failure -> print(result.error)
                }
            }
        }
    }
}