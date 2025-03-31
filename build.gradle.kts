plugins {
    kotlin("jvm") version "2.1.10"
}

group = "org.gamelike"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

val freemarkerVersion = "2.3.34"

dependencies {
    // https://mvnrepository.com/artifact/org.freemarker/freemarker
    implementation("org.freemarker:freemarker:$freemarkerVersion")
    testImplementation(kotlin("test"))
}

tasks.test {
    useJUnitPlatform()
}
kotlin {
    jvmToolchain(17)
}