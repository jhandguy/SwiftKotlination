object Dependencies {
    fun anko(module: String? = null, version: String) = "org.jetbrains.anko:anko${module?.let { "-$module" } ?: ""}:$version"
    fun appCompat(version: String) = "androidx.appcompat:appcompat:$version"
    fun buildTools(module: String, version: String) = "com.android.tools.build:$module:$version"
    fun constraintLayout(version: String) = "androidx.constraintlayout:constraintlayout:$version"
    fun espresso(module: String, version: String) = "androidx.test.espresso:espresso-$module:$version"
    fun fastlane(module: String, version: String) = "tools.fastlane:$module:$version"
    fun jacoco(version: String) = "org.jacoco:org.jacoco.core:$version"
    fun junit(version: String) = "junit:junit:$version"
    fun kotlinx(module: String, version: String) = "org.jetbrains.kotlinx:kotlinx-$module:$version"
    fun recyclerView(version: String) = "androidx.recyclerview:recyclerview:$version"
    fun robolectric(version: String) = "org.robolectric:robolectric:$version"
    fun test(module: String, version: String) = "androidx.test:$module:$version"
}
