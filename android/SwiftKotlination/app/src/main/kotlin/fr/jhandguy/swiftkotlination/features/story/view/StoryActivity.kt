package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.App
import fr.jhandguy.swiftkotlination.features.story.factory.StoryFactory
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.serialization.json.JSON
import org.jetbrains.anko.setContentView

class StoryActivity: AppCompatActivity() {

    private val factory: StoryFactory   by lazy {  (application as App).factory }
    private val coordinator             by lazy {  factory.makeCoordinator(this) }
    private val viewModel               by lazy {  factory.makeStoryViewModel(JSON.parse(Story.serializer(), intent?.extras?.get(Story::class.java.simpleName) as String)) }
    private val view                    by lazy {  StoryView(this, viewModel, coordinator) }

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
                    when(result) {
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

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }
}