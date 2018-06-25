package fr.jhandguy.swiftkotlination.features.story.view

import android.graphics.Color
import android.graphics.Typeface
import android.support.constraint.ConstraintLayout.LayoutParams.PARENT_ID
import android.view.View
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.*
import org.jetbrains.anko.constraint.layout.constraintLayout
import org.jetbrains.anko.sdk25.coroutines.onClick
import javax.inject.Inject

class StoryView @Inject constructor(var story: Story, var coordinator: Coordinator): AnkoComponent<StoryActivity> {
    override fun createView(ui: AnkoContext<StoryActivity>): View = with(ui) {
        return constraintLayout {
            padding = dip(10)
            lparams(width = matchParent, height = matchParent)

            textView {
                text = story.title
                textAlignment = View.TEXT_ALIGNMENT_CENTER
                textColorResource = R.color.colorAccent
                textSize = sp(9).toFloat()
                id = R.id.story_title
            }.lparams(width = matchParent, height = wrapContent) {
                topToTop = PARENT_ID
                leftToLeft = PARENT_ID
                rightToRight = PARENT_ID
                topMargin = dip(14)
            }

            textView {
                text = story.abstract
                textColorResource = R.color.colorAccent
                textSize = sp(6).toFloat()
                id = R.id.story_abstract
            }.lparams(width = matchParent, height = wrapContent) {
                topToBottom = R.id.story_title
                leftToLeft = PARENT_ID
                rightToRight = PARENT_ID
                topMargin = dip(14)
            }

            textView {
                text = story.byline
                textColorResource = R.color.colorAccent
                textSize = sp(4).toFloat()
                id = R.id.story_byline
            }.lparams(width = matchParent, height = wrapContent) {
                topToBottom = R.id.story_abstract
                leftToLeft = PARENT_ID
                rightToRight = PARENT_ID
                topMargin = dip(10)
            }

            button {
                textResource = R.string.story_button_title
                allCaps = false
                textColor = Color.RED
                typeface = Typeface.DEFAULT
                textSize = sp(6).toFloat()
                backgroundColor = Color.BLACK
                id = R.id.story_button

                onClick {
                    coordinator.open(story.url)
                }
            }.lparams(width = matchParent, height = wrapContent) {
                topToBottom = R.id.story_byline
                leftToLeft = PARENT_ID
                rightToRight = PARENT_ID
                topMargin = dip(12)
            }
        }
    }

}