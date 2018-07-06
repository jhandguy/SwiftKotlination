package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.ext.android.releaseContext

class StoryActivity: AppCompatActivity() {

    val coordinator: Coordinator by inject { mapOf("activity" to this) }

    val viewModel: StoryViewModel by inject { mapOf("story" to intent.extras.getSerializable(Story::class.java.simpleName)) }

    val view: StoryView by inject { mapOf("activity" to this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }

    override fun onStart() {
        super.onStart()

        viewModel
                .story
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe {
                    title = arrayOf(it.section, it.subsection)
                            .filter { it.isNotEmpty() }
                            .joinToString(separator = " - ")
                    view.story = it
                    view.setContentView(this)
                }
    }

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }

    override fun onStop() {
        super.onStop()
        releaseContext("story")
    }
}