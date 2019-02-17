package fr.jhandguy.swiftkotlination.features.story.view

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.view.View
import androidx.constraintlayout.widget.ConstraintSet
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.imageUrl
import fr.jhandguy.swiftkotlination.features.story.viewModel.StoryViewModel
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.observer.DisposeBag
import fr.jhandguy.swiftkotlination.observer.Result
import org.jetbrains.anko.AnkoComponent
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.allCaps
import org.jetbrains.anko.backgroundColor
import org.jetbrains.anko.button
import org.jetbrains.anko.constraint.layout.constraintLayout
import org.jetbrains.anko.dip
import org.jetbrains.anko.imageBitmap
import org.jetbrains.anko.imageView
import org.jetbrains.anko.matchParent
import org.jetbrains.anko.padding
import org.jetbrains.anko.scrollView
import org.jetbrains.anko.sp
import org.jetbrains.anko.textColorResource
import org.jetbrains.anko.textResource
import org.jetbrains.anko.textView
import org.jetbrains.anko.wrapContent

class StoryView(val activity: Activity, val viewModel: StoryViewModel, val coordinator: CoordinatorInterface, val disposeBag: DisposeBag = DisposeBag(), var story: Story = Story()) :
    AnkoComponent<Context> {

    override fun createView(ui: AnkoContext<Context>): View = with(ui) {
        return scrollView {
            constraintLayout {
                padding = dip(10)
                lparams(width = matchParent, height = matchParent)

                imageView {
                    id = R.id.story_image
                    adjustViewBounds = true
                    story.imageUrl(Multimedia.Format.Large)?.let { url ->
                        launch {
                            viewModel.image(url) { result ->
                                activity.runOnUiThread {
                                    imageBitmap = when (result) {
                                        is Result.Success -> result.data
                                        is Result.Failure -> {
                                            visibility = View.GONE
                                            null
                                        }
                                    }
                                }
                            }?.disposedBy(disposeBag)
                        }
                    } ?: run { visibility = View.GONE }
                }.lparams(width = matchParent, height = wrapContent) {
                    leftToLeft = ConstraintSet.PARENT_ID
                    topToTop = ConstraintSet.PARENT_ID
                    rightToRight = ConstraintSet.PARENT_ID
                }

                textView {
                    text = story.title
                    textAlignment = View.TEXT_ALIGNMENT_CENTER
                    textColorResource = R.color.primary_text
                    textSize = sp(10).toFloat()
                    id = R.id.story_title
                }.lparams(width = matchParent, height = wrapContent) {
                    topToBottom = R.id.story_image
                    leftToLeft = ConstraintSet.PARENT_ID
                    rightToRight = ConstraintSet.PARENT_ID
                    topMargin = dip(18)
                }

                textView {
                    text = story.abstract
                    textColorResource = R.color.primary_text
                    textSize = sp(7).toFloat()
                    id = R.id.story_abstract
                }.lparams(width = matchParent, height = wrapContent) {
                    topToBottom = R.id.story_title
                    leftToLeft = ConstraintSet.PARENT_ID
                    rightToRight = ConstraintSet.PARENT_ID
                    topMargin = dip(18)
                }

                textView {
                    text = story.byline
                    textColorResource = R.color.secondary_text
                    textSize = sp(6).toFloat()
                    id = R.id.story_byline
                }.lparams(width = matchParent, height = wrapContent) {
                    topToBottom = R.id.story_abstract
                    leftToLeft = ConstraintSet.PARENT_ID
                    rightToRight = ConstraintSet.PARENT_ID
                    topMargin = dip(16)
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
                    rightToRight = ConstraintSet.PARENT_ID
                    topMargin = dip(12)
                }
            }
        }
    }
}