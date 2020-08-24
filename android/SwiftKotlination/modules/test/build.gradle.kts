plugins {
    kotlin("jvm")
}

dependencies {
    implementation(project(":modules:network"))
    implementation(project(":modules:image"))
    implementation(kotlin("stdlib-jdk8", Versions.kotlinVersion))
}

sourceSets {
    getByName("main") {
        java.srcDirs("src/main/kotlin")
        resources.srcDirs("src/main/resources")
    }
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}
