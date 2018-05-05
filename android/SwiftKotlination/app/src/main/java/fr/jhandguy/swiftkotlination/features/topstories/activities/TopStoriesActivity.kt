package fr.jhandguy.swiftkotlination.features.topstories.activities

import android.graphics.Color
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import fr.jhandguy.swiftkotlination.Coordinator
import fr.jhandguy.swiftkotlination.CoordinatorInterface
import org.jetbrains.anko.textColor
import org.jetbrains.anko.textView
import org.jetbrains.anko.verticalLayout

class TopStoriesActivity: AppCompatActivity() {

    private val coordinator: CoordinatorInterface = Coordinator()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        title = "Top Stories"

        verticalLayout {
            textView("Title") {
                textColor = Color.WHITE
            }
            textView("Description") {
                textColor = Color.WHITE
            }
        }
    }
}