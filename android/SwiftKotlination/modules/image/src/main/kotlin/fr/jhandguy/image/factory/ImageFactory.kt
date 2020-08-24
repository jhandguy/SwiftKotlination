package fr.jhandguy.image.factory

import fr.jhandguy.image.model.ImageManagerInterface

interface ImageFactory {
    fun makeImageManager(): ImageManagerInterface
}
