package fr.jhandguy.topstories.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import fr.jhandguy.extension.coroutine.launch
import fr.jhandguy.extension.presenter.present
import fr.jhandguy.network.model.observer.DisposeBag
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.feature.TopStoriesFeature
import org.jetbrains.anko.setContentView

class TopStoriesActivity : AppCompatActivity() {

    private val factory by lazy { (application as TopStoriesFeature).topStoriesFactory }
    private val coordinator by lazy { factory.makeTopStoriesCoordinator(this) }
    private val viewModel by lazy { factory.makeTopStoriesViewModel() }
    private val adapter by lazy { TopStoriesAdapter(this, viewModel, coordinator) }
    private val view by lazy { TopStoriesView(adapter, viewModel) }
    private val disposeBag = DisposeBag()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = getString(R.string.top_stories_title)

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
                        is Result.Failure -> present(result.error)
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
