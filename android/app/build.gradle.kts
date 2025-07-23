plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.explore_nauta"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.explore_nauta"
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName

        manifestPlaceholders += mapOf(
            "facebook_app_id" to "717392541201614",
            "facebookClientToken" to "47415937398b22a62b3769cd7b627413",
            "fbLoginProtocolScheme" to "fb3020455181589285"
        )
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Usa tu release key si la tienes
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation(platform("com.google.firebase:firebase-bom:32.7.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth-ktx")

    // Facebook SDK actualizados
    implementation("com.facebook.android:facebook-android-sdk:16.3.0")
    implementation("com.facebook.android:facebook-login:16.3.0")
}
