plugins {
    id("com.android.library")
    jacoco
    kotlin("android")
}

android {
    compileSdkVersion(Versions.androidVersion)

    defaultConfig {
        // TODO: minSdkVersion(Versions.androidVersion)
        minSdkVersion(28)
        targetSdkVersion(Versions.androidVersion)
        buildToolsVersion(Versions.buildToolsVersion)
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
    }
}

dependencies {
    testImplementation(project(":modules:test"))

    implementation(Dependencies.appCompat(Versions.appCompatVersion))
    implementation(Dependencies.kotlinx("coroutines-android", Versions.coroutinesVersion))

    testImplementation(Dependencies.junit(Versions.junitVersion))
    testImplementation(kotlin("test-junit", Versions.kotlinVersion))
    testImplementation(Dependencies.robolectric(Versions.robolectricVersion))
    testImplementation(Dependencies.test("core", Versions.testVersion))
}

task("jacocoTestReport", JacocoReport::class) {
    dependsOn("testDebugUnitTest")

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
        files("$buildDir/jacoco/testDebugUnitTest.exec")
    )
}
