package fr.jhandguy.swiftkotlination.presenter

import android.app.Activity
import androidx.appcompat.app.AlertDialog

data class ErrorPresenter(val error: Error) {

    fun presentIn(activity: Activity) {
        AlertDialog
                .Builder(activity)
                .setTitle("Error")
                .setMessage(error.message)
                .setNegativeButton(android.R.string.ok, null)
                .show()
    }
}
