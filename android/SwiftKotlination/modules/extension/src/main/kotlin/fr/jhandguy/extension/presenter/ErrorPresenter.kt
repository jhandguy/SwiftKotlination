package fr.jhandguy.extension.presenter

import android.app.Activity
import androidx.appcompat.app.AlertDialog

internal data class ErrorPresenter(val error: Error) {

    fun presentIn(activity: Activity) {
        AlertDialog
            .Builder(activity)
            .setTitle("Error")
            .setMessage(error.message)
            .setNegativeButton(android.R.string.ok, null)
            .show()
    }
}

fun Activity.present(error: Error) = ErrorPresenter(error).presentIn(this)
