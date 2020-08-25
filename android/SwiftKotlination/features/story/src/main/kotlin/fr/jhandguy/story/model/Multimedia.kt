package fr.jhandguy.story.model

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.Serializer
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.JsonDecoder
import kotlinx.serialization.json.JsonEncoder
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.JsonPrimitive
import kotlinx.serialization.json.jsonPrimitive

@Serializable
data class Multimedia(val url: String = "", val format: Format = Format.Small) {
    sealed class Format(val name: String) {
        object Icon : Format("Standard Thumbnail")
        object Small : Format("thumbLarge")
        object Normal : Format("Normal")
        object Medium : Format("mediumThreeByTwo210")
        object Large : Format("superJumbo")
    }

    @Serializer(forClass = Multimedia::class)
    companion object {
        override fun serialize(encoder: Encoder, value: Multimedia) {
            val jsonEncoder = encoder as? JsonEncoder
                ?: throw SerializationException("Expected JSON encoder")

            val jsonObject = JsonObject(
                mapOf(
                    "url" to JsonPrimitive(value.url),
                    "format" to JsonPrimitive(value.format.name)
                )
            )

            jsonEncoder.encodeJsonElement(jsonObject)
        }

        override fun deserialize(decoder: Decoder): Multimedia {
            val jsonDecoder = decoder as? JsonDecoder
                ?: throw SerializationException("Expected JSON decoder")
            val jsonObject = jsonDecoder.decodeJsonElement() as? JsonObject
                ?: throw SerializationException("Expected JSON object")

            val url = jsonObject.getValue("url").jsonPrimitive.content
            val formatName = jsonObject.getValue("format").jsonPrimitive.content

            val format = when (formatName) {
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
