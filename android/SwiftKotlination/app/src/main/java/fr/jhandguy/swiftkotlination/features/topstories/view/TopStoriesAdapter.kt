package fr.jhandguy.swiftkotlination.features.topstories.view

import android.support.v7.widget.RecyclerView
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.features.topstories.model.Story
import org.jetbrains.anko.AnkoContext

class TopStoriesAdapter constructor(var topStories: List<Story> = ArrayList()): RecyclerView.Adapter<TopStoriesAdapter.ViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder =
            ViewHolder(TopStoriesItemView().createView(AnkoContext.create(parent.context)))

    override fun getItemCount(): Int =
            topStories.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) =
            holder.bind(topStories[position])

    class ViewHolder(itemView: View?) : RecyclerView.ViewHolder(itemView) {
        val title: TextView = itemView?.findViewById(R.id.top_stories_item_title) as TextView
        val byline: TextView = itemView?.findViewById(R.id.top_stories_item_byline) as TextView

        fun bind(story: Story){
            title.text = story.title
            byline.text = story.byline
        }
    }
}