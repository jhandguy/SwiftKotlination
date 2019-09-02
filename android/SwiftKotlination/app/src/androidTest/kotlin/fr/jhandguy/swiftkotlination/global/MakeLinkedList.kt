package fr.jhandguy.swiftkotlination.global

import java.util.LinkedList

fun <T> linkedListOf(vararg items: T) = LinkedList<T>().apply {
    for (i in items) { add(i) }
}
