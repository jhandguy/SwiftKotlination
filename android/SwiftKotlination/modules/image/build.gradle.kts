plugins {
    jacoco
    kotlin("jvm")
}

dependencies {
    implementation(project(":modules:network"))
    testImplementation(project(":modules:test"))

    implementation(kotlin("stdlib-jdk8", Versions.kotlinVersion))
    testImplementation(kotlin("test-junit", Versions.kotlinVersion))
    testImplementation(Dependencies.kotlinx("coroutines-core", Versions.coroutinesVersion))
}

sourceSets {
    getByName("main") {
        java.srcDirs("src/main/kotlin")
    }

    getByName("test") {
        java.srcDirs("src/test/kotlin")
    }
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}

tasks.jacocoTestReport {
    dependsOn("test")

    reports {
        xml.isEnabled = true
        html.isEnabled = true
    }

    sourceDirectories.setFrom(
        files("$projectDir/src/main/kotlin")
    )

    classDirectories.setFrom(
        files("$buildDir/classes/kotlin/main")
    )

    executionData.setFrom(
        files("$buildDir/jacoco/test.exec")
    )
}
