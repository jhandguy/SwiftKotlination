package fr.jhandguy.topstories.model

import fr.jhandguy.story.model.Story
import kotlinx.serialization.Serializable

@Serializable
data class TopStories(val results: List<Story>)
