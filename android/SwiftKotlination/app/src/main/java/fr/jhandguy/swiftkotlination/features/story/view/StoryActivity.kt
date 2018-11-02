package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.Result
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.scope.ext.android.bindScope
import org.koin.android.scope.ext.android.getOrCreateScope
import org.koin.core.parameter.parametersOf

class StoryActivity: AppCompatActivity() {

    val coordinator: Coordinator by inject { parametersOf(this) }

    val viewModel: StoryViewModel by inject { parametersOf(intent?.extras?.get(Story::class.java.simpleName) ?: Story()) }

    val view: StoryView by inject { parametersOf(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        bindScope(getOrCreateScope("story"))

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }

    override fun onStart() {
        super.onStart()

        CoroutineScope(Dispatchers.Main).launch {
            viewModel.story { result ->
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

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }
}