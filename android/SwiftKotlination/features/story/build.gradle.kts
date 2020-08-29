plugins {
    id("com.android.library")
    jacoco
    id("kotlinx-serialization")
    kotlin("android")
    kotlin("android.extensions")
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
    implementation(project(":modules:extension"))
    implementation(project(":modules:image"))
    implementation(project(":modules:network"))
    testImplementation(project(":modules:test"))

    implementation(Dependencies.anko(version = Versions.ankoVersion))
    implementation(Dependencies.anko("constraint-layout", Versions.ankoVersion))
    implementation(Dependencies.appCompat(Versions.appCompatVersion))
    implementation(Dependencies.constraintLayout(Versions.constraintLayoutVersion))
    implementation(Dependencies.kotlinx("serialization-runtime", Versions.serializationVersion))

    testImplementation(Dependencies.junit(Versions.junitVersion))
    testImplementation(Dependencies.robolectric(Versions.robolectricVersion))
    testImplementation(Dependencies.test("core", Versions.testVersion))
    testImplementation(kotlin("test-junit", Versions.kotlinVersion))
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
