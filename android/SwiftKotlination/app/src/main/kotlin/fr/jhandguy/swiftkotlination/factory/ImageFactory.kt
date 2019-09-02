package fr.jhandguy.swiftkotlination.factory

import fr.jhandguy.swiftkotlination.model.ImageManagerInterface

interface ImageFactory {
    fun makeImageManager(): ImageManagerInterface
}
