import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Nombre obligatorio del artefacto APK
val requiredApkBaseName = "nahuatl_app"

android {
    namespace = "com.example.nahuatl_clasico_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.nahuatl_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        setProperty("archivesBaseName", requiredApkBaseName)
    }

    buildTypes {
        release {
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// Empaquetado y Validación estricta del nombre del APK (`nahuatl_app.apk`) al ejecutar `flutter build apk`
val buildVariantMap = mapOf(
    "assembleRelease" to "release",
    "assembleDebug" to "debug",
    "assembleProfile" to "profile"
)

tasks.configureEach {
    val variantName = buildVariantMap[name]
    if (variantName != null) {
        doLast {
            val flutterApkDir = layout.buildDirectory.dir("outputs/flutter-apk").get().asFile
            if (!flutterApkDir.exists()) {
                flutterApkDir.mkdirs()
            }

            // Busca el APK generado por el pipeline de Flutter/Gradle
            val candidateSources = listOf(
                File(flutterApkDir, "${requiredApkBaseName}-${variantName}.apk"),
                File(flutterApkDir, "app-${variantName}.apk"),
                layout.buildDirectory.file("outputs/apk/${variantName}/${requiredApkBaseName}-${variantName}.apk").get().asFile,
                layout.buildDirectory.file("outputs/apk/${variantName}/app-${variantName}.apk").get().asFile
            )

            val sourceApk = candidateSources.firstOrNull { it.exists() && it.length() > 0L }
                ?: throw GradleException(
                    "Error de validación APK: No se encontró el archivo APK base para la variante '$variantName' en ${flutterApkDir.absolutePath}"
                )

            // 1. Garantizar compatibilidad con el verificador CLI de Flutter (`app-<variant>.apk`)
            val flutterCliExpectedApk = File(flutterApkDir, "app-${variantName}.apk")
            if (sourceApk.absolutePath != flutterCliExpectedApk.absolutePath) {
                sourceApk.copyTo(flutterCliExpectedApk, overwrite = true)
            }

            // 2. Generar el APK con el nombre requerido: `nahuatl_app.apk` y `nahuatl_app-<variant>.apk`
            val namedVariantApk = File(flutterApkDir, "${requiredApkBaseName}-${variantName}.apk")
            val primaryNamedApk = File(flutterApkDir, "${requiredApkBaseName}.apk")

            if (sourceApk.absolutePath != namedVariantApk.absolutePath) {
                sourceApk.copyTo(namedVariantApk, overwrite = true)
            }
            sourceApk.copyTo(primaryNamedApk, overwrite = true)

            // 3. Validación estricta post-build del archivo `nahuatl_app.apk`
            if (!primaryNamedApk.exists() ||
                primaryNamedApk.name != "${requiredApkBaseName}.apk" ||
                primaryNamedApk.length() <= 0L
            ) {
                throw GradleException(
                    "Fallo de validación: El APK final no se generó con el nombre '${requiredApkBaseName}.apk' o está vacío."
                )
            }

            println("✓ [VALIDACIÓN APK EXITOSA] Archivo generado: ${primaryNamedApk.name} (${primaryNamedApk.length()} bytes) en ${primaryNamedApk.absolutePath}")
        }
    }
}
