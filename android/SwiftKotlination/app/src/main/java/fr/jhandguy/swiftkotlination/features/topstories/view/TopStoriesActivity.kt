package fr.jhandguy.swiftkotlination.features.topstories.view

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.rxkotlin.subscribeBy
import io.reactivex.schedulers.Schedulers
import org.jetbrains.anko.setContentView
import org.koin.android.ext.android.inject
import org.koin.android.ext.android.releaseContext

class TopStoriesActivity: AppCompatActivity() {

    val viewModel: TopStoriesViewModel by inject()

    val view: TopStoriesView by inject { mapOf("activity" to this) }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        view.setContentView(this)
    }

    override fun onStart() {
        super.onStart()

        viewModel
                .topStories
                .subscribeOn(Schedulers.newThread())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribeBy(
                    onNext = {
                        view.adapter.topStories = it
                        view.adapter.notifyDataSetChanged()
                    },
                    onError = {
                        print(it.message)
                    }
                )
    }

    override fun onStop() {
        super.onStop()

        releaseContext("top-stories")
    }
}