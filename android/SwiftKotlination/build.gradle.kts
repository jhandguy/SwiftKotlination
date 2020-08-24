plugins {
    jacoco
}

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

    apply(plugin = "jacoco")

    tasks {
        withType<Test> {
            configure<JacocoTaskExtension> {
                isIncludeNoLocationClasses = true
            }
        }
    }
}

task("clean", Delete::class) {
    delete(rootProject.buildDir)
}

task("jacocoTestReport", JacocoReport::class) {
    val sourceFiles = mutableListOf<ConfigurableFileCollection>()
    val classFiles = mutableListOf<ConfigurableFileCollection>()
    val coverageFiles = mutableListOf<ConfigurableFileTree>()

    childProjects.forEach { child ->
        val project = child.value
        if (project.subprojects.isEmpty()) {
            dependsOn("${project.path}:jacocoTestReport")
            sourceFiles.add(files("${project.projectDir}/src/main/kotlin"))
            classFiles.add(files("${project.buildDir}/tmp/kotlin-classes/debug", "${project.buildDir}/classes/kotlin/main"))
            coverageFiles.add(
                fileTree(project.buildDir) {
                    setIncludes(setOf("jacoco/testDebugUnitTest.exec", "outputs/code_coverage/debugAndroidTest/connected/*coverage.ec", "jacoco/test.exec"))
                }
            )
        } else {
            project.subprojects.filterNot { it.name == "test" }.forEach {
                dependsOn("${it.path}:jacocoTestReport")
                sourceFiles.add(files("${it.projectDir}/src/main/kotlin"))
                classFiles.add(files("${it.buildDir}/tmp/kotlin-classes/debug", "${it.buildDir}/classes/kotlin/main"))
                coverageFiles.add(
                    fileTree(it.buildDir) {
                        setIncludes(setOf("jacoco/testDebugUnitTest.exec", "outputs/code_coverage/debugAndroidTest/connected/*coverage.ec", "jacoco/test.exec"))
                    }
                )
            }
        }
    }

    reports {
        xml.isEnabled = true
        html.isEnabled = true
    }

    sourceDirectories.setFrom(sourceFiles)
    classDirectories.setFrom(classFiles)
    executionData.setFrom(coverageFiles)
}
