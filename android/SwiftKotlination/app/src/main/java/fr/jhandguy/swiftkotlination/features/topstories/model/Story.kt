package fr.jhandguy.swiftkotlination.features.topstories.model

import java.io.Serializable

data class Story(
        var section: String,
        var subsection: String,
        var title: String,
        var abstract: String,
        var url: String,
        var byline: String): Serializable