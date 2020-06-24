plugins {
    id("com.android.application")
    id("jacoco")
    id("kotlinx-serialization")
    kotlin("android")
    kotlin("android.extensions")
    kotlin("kapt")
}

android {
    compileSdkVersion(30)

    defaultConfig {
        applicationId = "fr.jhandguy.swiftkotlination"
        // TODO: minSdkVersion(30)
        minSdkVersion(28)
        targetSdkVersion(30)
        buildToolsVersion("30.0.0")
        versionCode = 1
        versionName = "1.0"
        testInstrumentationRunner = "fr.jhandguy.swiftkotlination.runner.AndroidTestRunner"
    }

    buildTypes {
        getByName("debug") {
            isTestCoverageEnabled = true
        }

        getByName("release") {
            isMinifyEnabled = true
        }
    }

    testOptions {
        // TODO: execution "ANDROID_TEST_ORCHESTRATOR"
        animationsDisabled = true
        unitTests.isIncludeAndroidResources = true
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
            manifest.srcFile("src/main/AndroidManifest.xml")
        }

        getByName("test") {
            java.srcDirs("src/test/kotlin", "src/sharedTest/kotlin")
            resources.srcDirs("src/test/resources", "src/sharedTest/resources")
        }

        getByName("androidTest") {
            java.srcDirs("src/androidTest/kotlin", "src/sharedTest/kotlin")
            resources.srcDirs("src/androidTest/resources", "src/sharedTest/resources")
        }

        getByName("debug") {
            java.srcDirs("src/main/kotlin")
            manifest.srcFile("src/debug/AndroidManifest.xml")
        }
    }
}

dependencies {
    val ankoVersion: String by System.getProperties()
    val appCompatVersion: String by System.getProperties()
    val constraintLayoutVersion: String by System.getProperties()
    val espressoVersion: String by System.getProperties()
    val coroutinesVersion: String by System.getProperties()
    val junitVersion: String by System.getProperties()
    val kotlinVersion: String by System.getProperties()
    val recyclerViewVersion: String by System.getProperties()
    val robolectricVersion: String by System.getProperties()
    val screengrabVersion: String by System.getProperties()
    val serializationVersion: String by System.getProperties()
    val testVersion: String by System.getProperties()

    fun anko(module: String? = null, version: String) = "org.jetbrains.anko:anko${module?.let { "-$module" } ?: ""}:$version"
    fun appCompat(version: String) = "androidx.appcompat:appcompat:$version"
    fun constraintLayout(version: String) = "androidx.constraintlayout:constraintlayout:$version"
    fun espresso(module: String, version: String) = "androidx.test.espresso:espresso-$module:$version"
    fun fastlane(module: String, version: String) = "tools.fastlane:$module:$version"
    fun junit(version: String) = "junit:junit:$version"
    fun kotlinx(module: String, version: String) = "org.jetbrains.kotlinx:kotlinx-$module:$version"
    fun recyclerView(version: String) = "androidx.recyclerview:recyclerview:$version"
    fun robolectric(version: String) = "org.robolectric:robolectric:$version"
    fun test(module: String, version: String) = "androidx.test:$module:$version"

    // TODO: Replace Anko with Jetpack Compose
    implementation(anko(version = ankoVersion))
    implementation(anko("recyclerview-v7", ankoVersion))
    implementation(anko("constraint-layout", ankoVersion))
    implementation(appCompat(appCompatVersion))
    implementation(constraintLayout(constraintLayoutVersion))
    implementation(kotlinx("serialization-runtime", serializationVersion))
    implementation(kotlinx("coroutines-android", coroutinesVersion))
    implementation(recyclerView(recyclerViewVersion))

    testImplementation(junit(junitVersion))
    testImplementation(kotlin("test-junit", kotlinVersion))
    testImplementation(robolectric(robolectricVersion))
    testImplementation(test("core", testVersion))

    androidTestImplementation(espresso("core", espressoVersion))
    androidTestImplementation(espresso("intents", espressoVersion))
    androidTestImplementation(fastlane("screengrab", screengrabVersion))
    androidTestImplementation(test("core", testVersion))
    androidTestImplementation(test("runner", testVersion))
    androidTestImplementation(test("rules", testVersion))
}

tasks.register("jacocoTestReport", JacocoReport::class) {
    dependsOn("testDebugUnitTest", "createDebugCoverageReport")

    reports {
        xml.isEnabled = true
        html.isEnabled = true
    }

    sourceDirectories.setFrom(
            files("$projectDir/src/main/kotlin")
    )

    classDirectories.setFrom(
            fileTree("$buildDir/tmp/kotlin-classes/debug") {
                setExcludes(setOf("**/R.class", "**/R$*.class", "**/BuildConfig.*", "**/Manifest*.*", "**/*Test*.*", "android/**/*.*", "**/*$*.*"))
            }
    )

    executionData.setFrom(
            fileTree(buildDir) {
                setIncludes(setOf("jacoco/testDebugUnitTest.exec", "outputs/code_coverage/debugAndroidTest/connected/*coverage.ec"))
            }
    )
}