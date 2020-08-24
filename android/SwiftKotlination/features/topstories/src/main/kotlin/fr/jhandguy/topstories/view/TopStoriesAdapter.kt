package fr.jhandguy.topstories.view

import android.app.Activity
import android.graphics.Bitmap
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import fr.jhandguy.extension.coroutine.launch
import fr.jhandguy.network.model.observer.DisposeBag
import fr.jhandguy.network.model.observer.Result
import fr.jhandguy.story.model.Multimedia
import fr.jhandguy.story.model.Story
import fr.jhandguy.story.model.imageUrl
import fr.jhandguy.topstories.R
import fr.jhandguy.topstories.coordinator.TopStoriesCoordinatorInterface
import fr.jhandguy.topstories.viewmodel.TopStoriesViewModel
import org.jetbrains.anko.AnkoContext
import org.jetbrains.anko.find
import org.jetbrains.anko.imageBitmap

class TopStoriesAdapter(
    val activity: Activity,
    val viewModel: TopStoriesViewModel,
    val coordinator: TopStoriesCoordinatorInterface
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

    class ViewHolder(itemView: View, val coordinator: TopStoriesCoordinatorInterface) : RecyclerView.ViewHolder(itemView) {
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
