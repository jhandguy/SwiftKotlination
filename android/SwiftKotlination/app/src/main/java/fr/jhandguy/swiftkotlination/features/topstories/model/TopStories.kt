package fr.jhandguy.swiftkotlination.features.topstories.model

import fr.jhandguy.swiftkotlination.features.story.model.Story
import kotlinx.serialization.Serializable

@Serializable
data class TopStories(val results: List<Story>)