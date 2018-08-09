package fr.jhandguy.swiftkotlination.features.topstories.view

import android.content.Context
import android.graphics.Color
import android.support.v7.widget.LinearLayoutManager
import android.view.View
import org.jetbrains.anko.*
import org.jetbrains.anko.recyclerview.v7.recyclerView

class TopStoriesView(var adapter: TopStoriesAdapter): AnkoComponent<Context> {

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        relativeLayout {
            padding = dip(12)
            backgroundColor = Color.BLACK
            recyclerView {
                lparams(width = matchParent, height = matchParent)
                layoutManager = LinearLayoutManager(ctx)
                adapter = this@TopStoriesView.adapter
            }
        }
    }
}