package fr.jhandguy.swiftkotlination.features.topstories.view

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface.DEFAULT_BOLD
import android.support.constraint.ConstraintLayout.LayoutParams.PARENT_ID
import android.view.View
import fr.jhandguy.swiftkotlination.R
import org.jetbrains.anko.*
import org.jetbrains.anko.constraint.layout.constraintLayout

class TopStoriesItemView : AnkoComponent<Context> {

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        return constraintLayout {
            padding = dip(8)
            lparams(width = matchParent, height = wrapContent)

            textView {
                textColorResource = R.color.primary_text
                textSize = sp(6).toFloat()
                typeface = DEFAULT_BOLD
                id = R.id.top_stories_item_title
            }.lparams(width = 0, height = wrapContent) {
                leftToLeft = PARENT_ID
                topToTop = PARENT_ID
                rightToLeft = R.id.top_stories_item_button
            }

            textView {
                textColorResource = R.color.secondary_text
                textSize = sp(5).toFloat()
                lines = 1
                id = R.id.top_stories_item_byline
            }.lparams(width = 0, height = wrapContent) {
                leftToLeft = PARENT_ID
                topToBottom = R.id.top_stories_item_title
                bottomToBottom = PARENT_ID
                rightToLeft = R.id.top_stories_item_button
                topMargin = dip(6)
            }

            button {
                allCaps = false
                textSize = sp(6).toFloat()
                textResource = R.string.top_stories_button_title
                id = R.id.top_stories_item_button
                backgroundColor = Color.TRANSPARENT
                textColorResource = R.color.accent
            }.lparams(width = wrapContent, height = wrapContent) {
                rightToRight = PARENT_ID
                topToTop = PARENT_ID
                bottomToBottom = PARENT_ID
            }
        }
    }
}