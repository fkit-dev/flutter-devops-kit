# Android Signing Guide

This document explains how to configure Android app signing using Flutter DevOps Kit (`fkit`).

---

# Overview

FKIT automates Android signing setup for Flutter projects.

The signing workflow includes:

* generating keystore files
* creating `key.properties`
* validating signing setup
* updating `.gitignore`

This helps standardize Android release configuration across projects.

---

# Why Android Signing Matters

Android release builds require a signing key.

Without signing:

* Play Store uploads fail
* release APKs cannot be distributed properly
* app updates cannot be published

---

# FKIT Signing Commands

## Setup Signing

```bash id="a1jlwm"
fkit signing setup
```

Interactive signing setup wizard.

---

## Validate Signing

```bash id="b1jlwm"
fkit signing doctor
```

Checks:

* `key.properties`
* keystore existence
* Gradle files

---

# Signing Setup Flow

When running:

```bash id="c1jlwm"
fkit signing setup
```

FKIT prompts for:

* keystore alias
* store password
* key password
* organization/company

---

# Generated Files

FKIT generates:

```text id="d1jlwm"
android/key.properties
android/app/<alias>-keystore.jks
```

---

# Example `key.properties`

```properties id="e1jlwm"
storePassword=your_password
keyPassword=your_password
keyAlias=release
storeFile=release-keystore.jks
```

---

# `.gitignore` Updates

FKIT automatically adds:

```gitignore id="f1jlwm"
android/key.properties
android/app/*.jks
android/app/*.keystore
```

to prevent sensitive files from being committed.

---

# Gradle Configuration

FKIT currently validates Gradle setup but does not fully inject signing configs automatically.

You must manually configure signing inside:

```text id="g1jlwm"
android/app/build.gradle
```

OR:

```text id="h1jlwm"
android/app/build.gradle.kts
```

depending on your project.

---

# Groovy Gradle Example

## `build.gradle`

```gradle id="i1jlwm"
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(
        new FileInputStream(keystorePropertiesFile)
    )
}
```

---

## Signing Config

```gradle id="j1jlwm"
android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(
                keystoreProperties['storeFile']
            )
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

---

# Kotlin DSL Example

## `build.gradle.kts`

```kotlin id="k1jlwm"
// Use java.util.Properties and java.io.FileInputStream directly
val keystoreProperties = java.util.Properties()

val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(
        java.io.FileInputStream(keystorePropertiesFile)
    )
}
```

---

## Signing Config

```kotlin id="l1jlwm"
android {
    signingConfigs {
        create("release") {
            keyAlias =
                keystoreProperties["keyAlias"] as String

            keyPassword =
                keystoreProperties["keyPassword"] as String

            storeFile = file(
                keystoreProperties["storeFile"] as String
            )

            storePassword =
                keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig =
                signingConfigs.getByName("release")
        }
    }
}
```

---

# Validate Signing

Run:

```bash id="m1jlwm"
fkit signing doctor
```

Checks:

* `android/key.properties`
* keystore existence
* Gradle file existence

---

# Recommended Workflow

## First-Time Setup

```bash id="n1jlwm"
fkit signing setup
```

---

## Configure Gradle

Add signing config manually.

---

## Validate

```bash id="o1jlwm"
fkit signing doctor
```

---

## Build Release APK

```bash id="p1jlwm"
fkit build apk production
```

---

# Common Errors

## Keystore Missing

Error:

```text id="q1jlwm"
Keystore missing
```

Solution:

* regenerate keystore
* verify `storeFile`
* verify keystore path

---

## Invalid Password

Error:

```text id="r1jlwm"
Keystore was tampered with
```

Usually caused by incorrect password.

---

## key.properties Missing

Error:

```text id="s1jlwm"
android/key.properties missing
```

Solution:

```bash id="t1jlwm"
fkit signing setup
```

---

## Gradle Signing Not Configured

Error during release build:

```text id="u1jlwm"
SigningConfig release missing
```

Solution:

* configure signingConfigs
* attach release signingConfig

---

# Best Practices

## Recommended

* Keep separate signing keys per organization
* Store backups securely
* Restrict keystore access
* Use strong passwords
* Validate signing before releases

---

## Avoid

* committing keystores to Git
* sharing signing keys publicly
* using weak passwords
* losing production signing keys

Losing production signing keys may prevent future Play Store updates.

---

# Security Recommendations

## Store Backups Securely

Recommended:

* encrypted cloud storage
* password manager vault
* offline backup drive

---

## Restrict Access

Only authorized team members should access:

```text id="v1jlwm"
.jks
.keystore
key.properties
```

---

# Future Scope

Planned FKIT signing improvements:

* automatic Gradle injection
* signing key rotation
* CI/CD secret generation
* encrypted local storage
* Play Store integration
* keystore backup workflows

---

# Related Documentation

* `configuration.md`
* `commands.md`
* `firebase.md`
