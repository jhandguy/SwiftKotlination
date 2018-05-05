package fr.jhandguy.swiftkotlination

import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity

class MainActivity: AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val intent = Intent(this, Coordinator.firstActivity)
        startActivity(intent)
        finish()
    }

}