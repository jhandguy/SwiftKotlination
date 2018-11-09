package fr.jhandguy.swiftkotlination.features.story.view

import android.content.Context
import android.graphics.Color
import android.support.constraint.ConstraintLayout.LayoutParams.PARENT_ID
import android.view.View
import fr.jhandguy.swiftkotlination.CoordinatorInterface
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.*
import org.jetbrains.anko.constraint.layout.constraintLayout

class StoryView(var coordinator: CoordinatorInterface, var story: Story = Story()): AnkoComponent<Context> {
    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        return constraintLayout {
            padding = dip(10)
            lparams(width = matchParent, height = matchParent)

            textView {
                text = story.title
                textAlignment = View.TEXT_ALIGNMENT_CENTER
                textColorResource = R.color.primary_text
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
                textColorResource = R.color.primary_text
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
                textColorResource = R.color.secondary_text
                textSize = sp(5).toFloat()
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
                textSize = sp(6).toFloat()
                id = R.id.story_button
                backgroundColor = Color.TRANSPARENT
                textColorResource = R.color.accent

                setOnClickListener {
                    coordinator.open(story.url)
                }
            }.lparams(width = wrapContent, height = wrapContent) {
                topToBottom = R.id.story_byline
                leftToLeft = PARENT_ID
                rightToRight = PARENT_ID
                topMargin = dip(12)
            }
        }
    }

}