package fr.jhandguy.story.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import fr.jhandguy.extension.coroutine.launch
import fr.jhandguy.extension.presenter.present
import fr.jhandguy.network.model.observer.DisposeBag
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.feature.StoryFeature
import fr.jhandguy.story.model.Story
import kotlinx.serialization.json.Json
import org.jetbrains.anko.setContentView

class StoryActivity : AppCompatActivity() {

    private val factory by lazy { (application as StoryFeature).storyFactory }
    private val coordinator by lazy { factory.makeStoryCoordinator(this) }
    private val viewModel by lazy {
        val story = intent?.extras?.getString(Story::class.java.simpleName)?.let {
            Json { allowStructuredMapKeys = true }.decodeFromString(Story.serializer(), it)
        } ?: Story()
        factory.makeStoryViewModel(story)
    }
    private val view by lazy { StoryView(this, viewModel, coordinator, disposeBag) }
    private val disposeBag = DisposeBag()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }

    override fun onStart() {
        super.onStart()

        launch {
            viewModel.story { result ->
                runOnUiThread {
                    when (result) {
                        is Result.Success -> {
                            title = arrayOf(result.data.section, result.data.subsection)
                                .filter { it.isNotEmpty() }
                                .joinToString(separator = " - ")
                            view.story = result.data
                            view.setContentView(this@StoryActivity)
                        }
                        is Result.Failure -> present(result.error)
                    }
                }
            }
        }
    }

    override fun onStop() {
        super.onStop()

        disposeBag.dispose()
    }

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }
}
