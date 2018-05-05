package fr.jhandguy.swiftkotlination

import fr.jhandguy.swiftkotlination.features.topstories.activities.TopStoriesActivity

interface CoordinatorInterface {

}

class Coordinator: CoordinatorInterface {

    companion object {
        val firstActivity = TopStoriesActivity::class.java
    }

}