package fr.jhandguy.swiftkotlination.features.story.model

import fr.jhandguy.swiftkotlination.model.Multimedia
import kotlinx.serialization.Serializable

@Serializable
data class Story(
        val section: String = "",
        val subsection: String = "",
        val title: String = "",
        val abstract: String = "",
        val url: String = "",
        val byline: String = "",
        val multimedia: List<Multimedia> = emptyList())