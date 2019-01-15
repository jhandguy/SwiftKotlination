package fr.jhandguy.swiftkotlination.features.topstories.view

import android.content.Context
import android.graphics.Typeface.DEFAULT_BOLD
import android.view.View
import androidx.constraintlayout.widget.ConstraintSet
import fr.jhandguy.swiftkotlination.R
import org.jetbrains.anko.AnkoComponent
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.constraint.layout.constraintLayout
import org.jetbrains.anko.dip
import org.jetbrains.anko.imageView
import org.jetbrains.anko.matchParent
import org.jetbrains.anko.padding
import org.jetbrains.anko.sp
import org.jetbrains.anko.textColorResource
import org.jetbrains.anko.textView
import org.jetbrains.anko.wrapContent

class TopStoriesItemView : AnkoComponent<Context> {

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        return constraintLayout {
            padding = dip(8)
            lparams(width = matchParent, height = dip(150))

            imageView {
                id = R.id.top_stories_item_image
            }.lparams(dip(135), dip(135)) {
                leftToLeft = ConstraintSet.PARENT_ID
                topToTop = ConstraintSet.PARENT_ID
                bottomToBottom = ConstraintSet.PARENT_ID
            }

            textView {
                textColorResource = R.color.primary_text
                textSize = sp(7).toFloat()
                typeface = DEFAULT_BOLD
                id = R.id.top_stories_item_title
            }.lparams(width = 0, height = wrapContent) {
                leftToRight = R.id.top_stories_item_image
                topToTop = ConstraintSet.PARENT_ID
                rightToRight = ConstraintSet.PARENT_ID
                bottomToTop = R.id.top_stories_item_byline
                verticalBias = 0.toFloat()
                leftMargin = dip(8)
                topMargin = dip(8)
            }

            textView {
                textColorResource = R.color.secondary_text
                textSize = sp(5).toFloat()
                id = R.id.top_stories_item_byline
            }.lparams(width = 0, height = wrapContent) {
                leftToRight = R.id.top_stories_item_image
                bottomToBottom = ConstraintSet.PARENT_ID
                rightToRight = ConstraintSet.PARENT_ID
                leftMargin = dip(8)
                bottomMargin = dip(8)
            }
        }
    }
}