package fr.jhandguy.swiftkotlination.features.story.model

import kotlinx.serialization.Serializable

@Serializable
data class Story(
        val section: String = "",
        val subsection: String = "",
        val title: String = "",
        val abstract: String = "",
        val url: String = "",
        val byline: String = "")