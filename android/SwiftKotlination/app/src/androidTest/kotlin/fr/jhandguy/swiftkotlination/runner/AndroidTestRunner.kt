package fr.jhandguy.swiftkotlination.runner

import android.app.Application
import android.content.Context
import androidx.test.runner.AndroidJUnitRunner
import fr.jhandguy.swiftkotlination.application.AppMock

class AndroidTestRunner : AndroidJUnitRunner() {
    override fun newApplication(cl: ClassLoader?, className: String?, context: Context?): Application {
        val appMockName = AppMock::class.java.canonicalName
        return super.newApplication(cl, appMockName, context)
    }
}
