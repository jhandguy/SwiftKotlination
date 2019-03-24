package fr.jhandguy.swiftkotlination.network

import java.io.InputStream

class File(name: String, extension: Extension) {
    enum class Extension {
        JSON, JPG;
        var value: String = name.toLowerCase()
    }

    val data: InputStream? = javaClass.classLoader?.getResourceAsStream("$name.${extension.value}")
}