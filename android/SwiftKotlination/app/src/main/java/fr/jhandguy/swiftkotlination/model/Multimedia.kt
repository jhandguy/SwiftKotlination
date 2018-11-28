package fr.jhandguy.swiftkotlination.model

import kotlinx.serialization.*
import kotlinx.serialization.json.JSON
import kotlinx.serialization.json.JsonLiteral
import kotlinx.serialization.json.JsonObject

@Serializable
data class Multimedia(val url: String = "", val format: Format = Format.Small) {
    sealed class Format(val name: String) {
        object Icon:    Format("Standard Thumbnail")
        object Small:   Format("thumbLarge")
        object Normal:  Format("Normal")
        object Medium:  Format("mediumThreeByTwo210")
        object Large:   Format("superJumbo")
    }

    @Serializer(forClass = Multimedia::class)
    companion object {
        override fun serialize(output: Encoder, obj: Multimedia) {
            val jsonOutput = output as? JSON.JsonOutput
                    ?: throw SerializationException("Expected JSON output")

            val jsonObject = JsonObject(mapOf(
                    "url"       to JsonLiteral(obj.url),
                    "format"    to JsonLiteral(obj.format.name)
            ))

            jsonOutput.writeTree(jsonObject)
        }

        override fun deserialize(input: Decoder): Multimedia {
            val jsonInput = input as? JSON.JsonInput
                    ?: throw SerializationException("Expected JSON input")
            val jsonObject = jsonInput.readAsTree() as? JsonObject
                    ?: throw SerializationException("Expected JSON object")

            val url =           jsonObject.getPrimitive("url").content
            val formatName =    jsonObject.getPrimitive("format").content

            val format = when(formatName) {
                Format.Icon.name -> Format.Icon
                Format.Small.name -> Format.Small
                Format.Normal.name -> Format.Normal
                Format.Medium.name -> Format.Medium
                Format.Large.name -> Format.Large
                else -> throw SerializationException("Unknown format $formatName")
            }

            return Multimedia(url, format)
        }
    }
}