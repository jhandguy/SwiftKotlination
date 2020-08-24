package fr.jhandguy.swiftkotlination.extensions

import fr.jhandguy.network.model.network.Parameters

fun Parameters.query(): String? =
    when (this) {
        is Parameters.Url -> {
            url.joinToString(separator = "&") { query ->
                query.second?.let {
                    "${query.first}=${query.second}"
                } ?: query.first
            }
        }
        else -> null
    }
