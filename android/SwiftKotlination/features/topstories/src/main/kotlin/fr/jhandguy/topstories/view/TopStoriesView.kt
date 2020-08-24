package fr.jhandguy.topstories.view

import android.content.Context
import android.view.View
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import fr.jhandguy.extension.coroutine.launch
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel
import org.jetbrains.anko.AnkoComponent
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.matchParent
import org.jetbrains.anko.recyclerview.v7.recyclerView
import org.jetbrains.anko.support.v4.onRefresh
import org.jetbrains.anko.support.v4.swipeRefreshLayout

class TopStoriesView(var adapter: TopStoriesAdapter, var viewModel: TopStoriesViewModel) : AnkoComponent<Context> {
    private lateinit var swipeRefreshLayout: SwipeRefreshLayout

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        swipeRefreshLayout = swipeRefreshLayout {
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
            field = value
            swipeRefreshLayout.isRefreshing = value
        }
}
