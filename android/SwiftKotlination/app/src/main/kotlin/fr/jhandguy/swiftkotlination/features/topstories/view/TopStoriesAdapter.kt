package fr.jhandguy.swiftkotlination.features.topstories.view

import android.app.Activity
import android.graphics.Bitmap
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import fr.jhandguy.swiftkotlination.R
import fr.jhandguy.swiftkotlination.coordinator.CoordinatorInterface
import fr.jhandguy.swiftkotlination.features.story.model.Story
import fr.jhandguy.swiftkotlination.features.story.model.imageUrl
import fr.jhandguy.swiftkotlination.features.topstories.viewmodel.TopStoriesViewModel
import fr.jhandguy.swiftkotlination.launch
import fr.jhandguy.swiftkotlination.model.Multimedia
import fr.jhandguy.swiftkotlination.observer.DisposeBag
import fr.jhandguy.swiftkotlination.observer.Result
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.imageBitmap

class TopStoriesAdapter(
    val activity: Activity,
    val viewModel: TopStoriesViewModel,
    val coordinator: CoordinatorInterface
) : RecyclerView.Adapter<TopStoriesAdapter.ViewHolder>() {

    private val disposeBag = DisposeBag()

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int) = ViewHolder(TopStoriesItemView().createView(AnkoContext.create(parent.context)), coordinator)

    override fun getItemCount() = viewModel.stories.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val story = viewModel.stories[position]
        holder.bind(story)

        story.imageUrl(Multimedia.Format.Small)?.let { url ->
            launch {
                viewModel.image(url) { result ->
                    activity.runOnUiThread {
                        when (result) {
                            is Result.Success -> holder.bind(result.data)
                            is Result.Failure -> holder.bind(null)
                        }
                    }
                }?.disposedBy(disposeBag)
            }
        } ?: holder.bind(null)
    }

    override fun onDetachedFromRecyclerView(recyclerView: RecyclerView) {
        super.onDetachedFromRecyclerView(recyclerView)
        disposeBag.dispose()
    }

    class ViewHolder(itemView: View, val coordinator: CoordinatorInterface) : RecyclerView.ViewHolder(itemView) {
        private val image: ImageView = itemView.find(R.id.top_stories_item_image)
        private val title: TextView = itemView.find(R.id.top_stories_item_title)
        private val byline: TextView = itemView.find(R.id.top_stories_item_byline)

        fun bind(story: Story) {
            title.text = story.title
            byline.text = story.byline
            itemView.setOnClickListener {
                coordinator.open(story)
            }
            bind(null)
        }

        fun bind(bitmap: Bitmap?) {
            image.imageBitmap = bitmap
            image.visibility = if (bitmap != null) View.VISIBLE else View.GONE
        }
    }
}