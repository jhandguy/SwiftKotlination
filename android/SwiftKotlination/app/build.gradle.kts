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
    // TODO: Replace Anko with Jetpack Compose
    implementation(Dependencies.anko(version = Versions.ankoVersion))
    implementation(Dependencies.anko("recyclerview-v7", Versions.ankoVersion))
    implementation(Dependencies.anko("constraint-layout", Versions.ankoVersion))
    implementation(Dependencies.appCompat(Versions.appCompatVersion))
    implementation(Dependencies.constraintLayout(Versions.constraintLayoutVersion))
    implementation(Dependencies.kotlinx("serialization-runtime", Versions.serializationVersion))
    implementation(Dependencies.kotlinx("coroutines-android", Versions.coroutinesVersion))
    implementation(Dependencies.recyclerView(Versions.recyclerViewVersion))

    testImplementation(Dependencies.junit(Versions.junitVersion))
    testImplementation(kotlin("test-junit", Versions.kotlinVersion))
    testImplementation(Dependencies.robolectric(Versions.robolectricVersion))
    testImplementation(Dependencies.test("core", Versions.testVersion))

    androidTestImplementation(Dependencies.espresso("core", Versions.espressoVersion))
    androidTestImplementation(Dependencies.espresso("intents", Versions.espressoVersion))
    androidTestImplementation(Dependencies.fastlane("screengrab", Versions.screengrabVersion))
    androidTestImplementation(Dependencies.test("core", Versions.testVersion))
    androidTestImplementation(Dependencies.test("runner", Versions.testVersion))
    androidTestImplementation(Dependencies.test("rules", Versions.testVersion))
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