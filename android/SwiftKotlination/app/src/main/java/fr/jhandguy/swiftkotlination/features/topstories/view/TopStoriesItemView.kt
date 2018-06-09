package fr.jhandguy.swiftkotlination.features.topstories.view

import android.content.Context
import android.view.View
import fr.jhandguy.swiftkotlination.R
import org.jetbrains.anko.*

class TopStoriesItemView : AnkoComponent<Context> {

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        return verticalLayout {
            padding = dip(6)
            textView {
                textColorResource = R.color.colorPrimary
                textSize = sp(8).toFloat()
                id = R.id.top_stories_item_title
            }
            textView {
                textColorResource = R.color.colorPrimaryDark
                textSize = sp(5).toFloat()
                id = R.id.top_stories_item_byline
            }
        }
    }
}