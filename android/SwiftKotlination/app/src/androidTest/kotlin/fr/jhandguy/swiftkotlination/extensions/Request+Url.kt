package fr.jhandguy.swiftkotlination.extensions

import fr.jhandguy.network.model.network.Request

fun Request.absoluteUrl(): String =
    parameters.query()?.let { query ->
        "$url?$query"
    } ?: url
