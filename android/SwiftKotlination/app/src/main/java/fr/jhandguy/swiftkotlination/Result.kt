package fr.jhandguy.swiftkotlination

sealed class Result<out T: Any> {
    data class Success<out T: Any>(val data: T): Result<T>()
    data class Failure(val error: Error): Result<Nothing>()
}
