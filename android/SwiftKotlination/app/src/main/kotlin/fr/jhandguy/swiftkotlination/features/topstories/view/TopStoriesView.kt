package fr.jhandguy.swiftkotlination.features.topstories.view

import android.content.Context
import android.support.v4.widget.SwipeRefreshLayout
import android.support.v7.widget.LinearLayoutManager
import android.view.View
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.launch
import org.jetbrains.anko.*
import org.jetbrains.anko.recyclerview.v7.recyclerView
import org.jetbrains.anko.support.v4.onRefresh
import org.jetbrains.anko.support.v4.swipeRefreshLayout

class TopStoriesView(var adapter: TopStoriesAdapter, var viewModel: TopStoriesViewModel): AnkoComponent<Context> {
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        swipeRefreshLayout = swipeRefreshLayout {
            padding = dip(12)
            onRefresh {
                launch {
                    viewModel.refresh()
                }
            }
            recyclerView {
                lparams(width = matchParent, height = matchParent)
                layoutManager = LinearLayoutManager(ctx)
                adapter = this@TopStoriesView.adapter
                id = R.id.top_stories_list
            }
        }

        return swipeRefreshLayout
    }

    var isRefreshing: Boolean = false
        set(value) {
            swipeRefreshLayout.isRefreshing = value
        }
}