buildscript {
    repositories {
        google()
        jcenter()
    }

    dependencies {
        val gradleVersion: String by System.getProperties()
        val jacocoVersion: String by System.getProperties()
        val kotlinVersion: String by System.getProperties()

        fun buildTools(module: String, version: String) = "com.android.tools.build:$module:$version"
        fun jacoco(version: String) = "org.jacoco:org.jacoco.core:$version"

        classpath(buildTools("gradle", gradleVersion))
        classpath(kotlin("gradle-plugin", kotlinVersion))
        classpath(kotlin("serialization", kotlinVersion))
        classpath(jacoco(jacocoVersion))
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