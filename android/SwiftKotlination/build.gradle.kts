buildscript {
    repositories {
        google()
        jcenter()
    }

    dependencies {
        classpath(Dependencies.buildTools("gradle", Versions.gradleVersion))
        classpath(Dependencies.jacoco(Versions.jacocoVersion))
        classpath(kotlin("gradle-plugin", Versions.kotlinVersion))
        classpath(kotlin("serialization", Versions.kotlinVersion))
    }
}

allprojects {
    repositories {
        google()
        jcenter()
    }
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}