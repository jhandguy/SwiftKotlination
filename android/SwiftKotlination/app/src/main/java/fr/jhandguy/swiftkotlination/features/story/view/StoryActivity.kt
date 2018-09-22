package fr.jhandguy.swiftkotlination.features.story.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.schedulers.Schedulers
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.scope.ext.android.bindScope
import org.koin.android.scope.ext.android.getOrCreateScope
import org.koin.core.parameter.parametersOf

class StoryActivity: AppCompatActivity() {

    val coordinator: Coordinator by inject { parametersOf(this) }

    val viewModel: StoryViewModel by inject { parametersOf(intent.extras.getSerializable(Story::class.java.simpleName)) }

    val view: StoryView by inject { parametersOf(this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        bindScope(getOrCreateScope("story"))

        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        supportActionBar?.setDisplayShowHomeEnabled(true)
    }

    override fun onStart() {
        super.onStart()

        viewModel
                .story
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeBy(
                        onNext = { story ->
                            title = arrayOf(story.section, story.subsection)
                                    .filter { it.isNotEmpty() }
                                    .joinToString(separator = " - ")
                            view.story = story
                            view.setContentView(this)
                        },
                        onError = {
                            print(it.message)
                        }
                )
    }

    override fun onSupportNavigateUp(): Boolean {
        coordinator.finish()
        return true
    }
}