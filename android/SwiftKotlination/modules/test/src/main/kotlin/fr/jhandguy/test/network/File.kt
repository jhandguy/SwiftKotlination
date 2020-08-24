package fr.jhandguy.test.network

import java.io.InputStream
import java.util.Locale

class File(val name: String, val extension: Extension) {
    enum class Extension {
        JSON, JPG;
        var value: String = name.toLowerCase(Locale.ROOT)
    }

    val data: InputStream?
        get() = javaClass.classLoader?.getResourceAsStream("$name.${extension.value}")
}
