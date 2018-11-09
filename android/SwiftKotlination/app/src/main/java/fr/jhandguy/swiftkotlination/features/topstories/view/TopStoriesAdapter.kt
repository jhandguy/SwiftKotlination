package fr.jhandguy.swiftkotlination.features.topstories.view

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import fr.jhandguy.swiftkotlination.navigation.CoordinatorInterface
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.story.model.Story
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find

class TopStoriesAdapter(val coordinator: CoordinatorInterface, var topStories: List<Story> = ArrayList()): RecyclerView.Adapter<TopStoriesAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ViewHolder(TopStoriesItemView().createView(AnkoContext.create(parent.context)), coordinator)

    override fun getItemCount() = topStories.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) = holder.bind(topStories[position])

    class ViewHolder(itemView: View, val coordinator: CoordinatorInterface) : RecyclerView.ViewHolder(itemView) {
        val title: TextView = itemView.find(R.id.top_stories_item_title)
        val byline: TextView = itemView.find(R.id.top_stories_item_byline)

        fun bind(story: Story) {
            title.text = story.title
            byline.text = story.byline
            itemView.setOnClickListener {
                coordinator.open(story)
            }
        }
    }
}