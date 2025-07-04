plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
//    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin")
}

//// Load secrets.properties
//val secretsFile = file("../secrets.properties") // Sesuaikan path jika diperlukan
//val secrets = Properties().apply {
//    load(FileInputStream(secretsFile))
//}

android {
    namespace = "com.imaldi.work_order_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.imaldi.work_order_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

//        // Ambil API key dari secrets.properties
//        resValue("string", "google_maps_api_key", secrets.getProperty("GOOGLE_API_KEY"))
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
//
//    buildFeatures {
//        buildConfig = true
//    }
}

flutter {
    source = "../.."
}

//dependencies {
//
//    // Maps SDK for Android
//    implementation("com.google.android.gms:play-services-maps:19.0.0")
//}