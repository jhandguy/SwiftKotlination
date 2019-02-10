package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.observer.DisposeBag
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.serialization.json.Json
import org.jetbrains.anko.setContentView

class StoryActivity : AppCompatActivity() {

    private val factory: StoryFactory by lazy { (application as App).factory }
    private val coordinator by lazy { factory.makeCoordinator(this) }
    private val viewModel by lazy {
        val story = intent?.extras?.getString(Story::class.java.simpleName)?.let {
            Json.parse(Story.serializer(), it)
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
                        is Result.Failure -> print(result.error)
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