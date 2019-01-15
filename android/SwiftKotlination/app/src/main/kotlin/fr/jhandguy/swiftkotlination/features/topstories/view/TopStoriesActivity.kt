package fr.jhandguy.swiftkotlination.features.topstories.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.features.topstories.factory.TopStoriesFactory
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.observer.DisposeBag
import fr.jhandguy.swiftkotlination.observer.Result
import org.jetbrains.anko.setContentView

class TopStoriesActivity : AppCompatActivity() {

    private val factory: TopStoriesFactory by lazy { (application as App).factory }
    private val coordinator by lazy { factory.makeCoordinator(this) }
    private val viewModel by lazy { factory.makeTopStoriesViewModel() }
    private val adapter by lazy { TopStoriesAdapter(this, viewModel, coordinator) }
    private val view by lazy { TopStoriesView(adapter, viewModel) }
    private val disposeBag = DisposeBag()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        view.setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        view.isRefreshing = true
        launch {
            viewModel.topStories { result ->
                runOnUiThread {
                    when (result) {
                        is Result.Success -> {
                            adapter.notifyDataSetChanged()
                        }
                        is Result.Failure -> print(result.error)
                    }
                    view.isRefreshing = false
                }
            }.disposedBy(disposeBag)
        }
    }

    override fun onStop() {
        super.onStop()

        disposeBag.dispose()
    }
}