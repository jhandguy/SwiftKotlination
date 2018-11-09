package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.navigation.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.observer.Result
import kotlinx.serialization.json.JSON
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.scope.ext.android.bindScope
import org.koin.android.scope.ext.android.getOrCreateScope
import org.koin.core.parameter.parametersOf

class StoryActivity: AppCompatActivity() {

    val coordinator: CoordinatorInterface by inject { parametersOf(this) }

    val viewModel: StoryViewModel by inject { parametersOf(JSON.parse(Story.serializer(), intent?.extras?.get(Story::class.java.simpleName) as String)) }

    val view: StoryView by inject { parametersOf(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        bindScope(getOrCreateScope("story"))

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