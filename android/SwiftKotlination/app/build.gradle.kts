plugins {
    id("com.android.application")
    id("kotlinx-serialization")
    jacoco
    kotlin("android")
    kotlin("android.extensions")
    kotlin("kapt")
}

android {
    compileSdkVersion(Versions.androidVersion)

    defaultConfig {
        applicationId = "fr.jhandguy.swiftkotlination"
        // TODO: minSdkVersion(Versions.androidVersion)
        minSdkVersion(28)
        targetSdkVersion(Versions.androidVersion)
        buildToolsVersion(Versions.buildToolsVersion)
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
        // TODO: execution = "ANDROID_TEST_ORCHESTRATOR"
        animationsDisabled = true
        unitTests.isIncludeAndroidResources = true
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
            manifest.srcFile("src/main/AndroidManifest.xml")
        }

        getByName("test") {
            java.srcDirs("src/test/kotlin")
        }

        getByName("androidTest") {
            java.srcDirs("src/androidTest/kotlin")
        }

        getByName("debug") {
            java.srcDirs("src/main/kotlin")
            manifest.srcFile("src/debug/AndroidManifest.xml")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
        allWarningsAsErrors = true
    }
}

dependencies {
    implementation(project(":features:story"))
    implementation(project(":features:topstories"))
    implementation(project(":modules:extension"))
    implementation(project(":modules:image"))
    implementation(project(":modules:network"))
    testImplementation(project(":modules:test"))
    androidTestImplementation(project(":modules:test"))

    implementation(Dependencies.appCompat(Versions.appCompatVersion))
    implementation(Dependencies.kotlinx("serialization-runtime", Versions.serializationVersion))
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

task("jacocoTestReport", JacocoReport::class) {
    dependsOn("testDebugUnitTest", "createDebugCoverageReport")

    reports {
        xml.isEnabled = true
        html.isEnabled = true
    }

    sourceDirectories.setFrom(
        files("$projectDir/src/main/kotlin")
    )

    classDirectories.setFrom(
        files("$buildDir/tmp/kotlin-classes/debug")
    )

    executionData.setFrom(
        fileTree(buildDir) {
            setIncludes(setOf("jacoco/testDebugUnitTest.exec", "outputs/code_coverage/debugAndroidTest/connected/*coverage.ec"))
        }
    )
}
