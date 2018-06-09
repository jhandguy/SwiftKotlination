package fr.jhandguy.swiftkotlination.features.topstories.view

import android.graphics.Color
import android.support.v7.widget.LinearLayoutManager
import android.view.View
import org.jetbrains.anko.*
import org.jetbrains.anko.recyclerview.v7.recyclerView

class TopStoriesView constructor(private val topStoriesAdapter: TopStoriesAdapter): AnkoComponent<TopStoriesActivity> {

    override fun createView(ui: AnkoContext<TopStoriesActivity>): View = with(ui) {
        relativeLayout {
            padding = dip(16)
            backgroundColor = Color.BLACK
            recyclerView {
                lparams(width = matchParent, height = matchParent)
                layoutManager = LinearLayoutManager(ctx)
                adapter = topStoriesAdapter
            }
        }
    }
}