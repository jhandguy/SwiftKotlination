package fr.jhandguy.swiftkotlination.features.topstories.view

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.sdk25.coroutines.onClick
import javax.inject.Inject

class TopStoriesAdapter @Inject constructor(var topStories: List<Story> = ArrayList(), private val onClickCallback: (Story) -> Unit): RecyclerView.Adapter<TopStoriesAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ViewHolder(TopStoriesItemView().createView(AnkoContext.create(parent.context)), onClickCallback)

    override fun getItemCount() = topStories.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) = holder.bind(topStories[position])

    class ViewHolder(itemView: View, private val onClickCallback: (Story) -> Unit) : RecyclerView.ViewHolder(itemView) {
        val title: TextView = itemView.find(R.id.top_stories_item_title)
        val byline: TextView = itemView.find(R.id.top_stories_item_byline)
        val button: Button = itemView.find(R.id.top_stories_item_button)

        fun bind(story: Story) {
            title.text = story.title
            byline.text = story.byline
            button.isEnabled = true
            button.onClick {
                button.isEnabled = false
                onClickCallback(story)
            }
        }
    }
}