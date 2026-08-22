# FKIT Commands Guide

This document contains all available Flutter DevOps Kit (`fkit`) commands and their usage.

---

# Command Structure

Basic command format:

```bash id="hjlwm0"
fkit <command> [arguments] [options]
```

Example:

```bash id="u8jlwm"
fkit build apk production
```

---

# Help Commands

## Show Help

```bash id="i5jlwm"
fkit help
```

Displays all available commands.

---

# Initialization Commands

## Initialize FKIT

```bash id="’winiiii283"
fkit init
```

Interactive project setup wizard.

Generates:

```bash id="’winiiii284"
fkit.yaml
```

Prompts for:

* platforms
* flavors
* Firebase configs
* FVM usage
* generator templates

---

# Validation Commands

## Validate Environment

```bash id="’winiiii285"
fkit doctor
```

Checks required tooling:

* Flutter
* Dart
* Firebase CLI
* Java
* CocoaPods
* Git

---

## Validate Project Configuration

```bash id="’winiiii286"
fkit validate
```

Checks:

* entry file
* env files
* Firebase option files
* flavor configuration

---

# Configuration Commands

## Print Loaded Config

```bash id="’winiiii287"
fkit config
```

Displays parsed FKIT configuration.

Useful for debugging configuration issues.

---

# Flutter Project Commands

## Clean Project

```bash id="’winiiii288"
fkit clean
```

Equivalent to:

```bash id="’winiiii289"
flutter clean
```

---

## Fetch Dependencies

```bash id="’winiiii290"
fkit get
```

Equivalent to:

```bash id="’winiiii291"
flutter pub get
```

---

## Apply Dart Fixes

```bash id="’winiiii292"
fkit fix
```

Equivalent to:

```bash id="’winiiii293"
dart fix --apply
```

---

## Analyze Project

```bash id="’winiiii294"
fkit analyze
```

Equivalent to:

```bash id="’winiiii295"
dart analyze lib
```

---

## Format Project

```bash id="’winiiii296"
fkit format
```

Equivalent to:

```bash id="’winiiii297"
dart format lib
```

---

# Code Generation Commands

## Generate Files

```bash id="’winiiii298"
fkit generate
```

Equivalent to:

```bash id="’winiiii299"
flutter pub run build_runner build --delete-conflicting-outputs
```

Used for:

* Riverpod generators
* Freezed
* JSON serialization
* Retrofit
* FlutterGen

---

## Watch Generators

```bash id="’winiiii300"
fkit watch
```

Equivalent to:

```bash id="’winiiii301"
dart run build_runner watch --delete-conflicting-outputs
```

Continuously watches file changes.

---

# Run Commands

## Run Application

```bash id="’winiiii302"
fkit run production
```

Runs Flutter application.

---

# Run Modes

## Debug Mode

```bash id="’winiiii303"
fkit run production
```

Default mode.

---

## Profile Mode

```bash id="’winiiii304"
fkit run production -p
```

OR:

```bash id="’winiiii305"
fkit run production --profile
```

---

## Release Mode

```bash id="’winiiii306"
fkit run production -r
```

OR:

```bash id="’winiiii307"
fkit run production --release
```

---

# Platform Support

## Android

```bash id="’winiiii308"
fkit run production -t android
```

---

## iOS

```bash id="’winiiii309"
fkit run production -t ios
```

---

## Web

```bash id="’winiiii310"
fkit run production -t web
```

Web automatically skips Flutter flavor arguments.

---

# Build Commands

## APK Build

```bash id="’winiiii311"
fkit build apk production
```

Builds Android APK.

---

## AAB Build

```bash id="’winiiii312"
fkit build aab production
```

Builds Android App Bundle.

---

## IPA Build

```bash id="’winiiii313"
fkit build ipa production
```

Builds iOS IPA.

---

## Web Build

```bash id="’winiiii314"
fkit build web
```

OR:

```bash id="’winiiii315"
fkit build web production
```

Web builds automatically skip Flutter flavors.

---

# Firebase Commands

## Upload To Firebase App Distribution

```bash id="’winiiii316"
fkit firebase production
```

Builds APK and uploads to Firebase App Distribution.

---

## Upload With Release Notes

```bash id="’winiiii317"
fkit firebase production --notes="QA regression build"
```

---

# Android Signing Commands

## Setup Android Signing

```bash id="’winiiii318"
fkit signing setup
```

Generates:

* keystore
* key.properties
* .gitignore entries

---

## Validate Android Signing

```bash id="’winiiii319"
fkit signing doctor
```

Checks:

* key.properties
* keystore existence
* Gradle files

---

# Feature Scaffolding Commands

## Create Feature Module

```bash id="’winiiii320"
fkit feat auth
```

Generates feature folder structure.

Use `--force` (or `--yes`) to overwrite generated files without prompts in
setup, module installation, feature generation, component generation, and
localization generation. Use `--no-build-runner` with feature and component
generation when the build step will be run separately.

Generated feature files require the selected template's declared runtime and
development dependencies.

Supported templates:

* BLoC Clean Architecture (current, production-ready)
* Riverpod Clean Architecture (planned)
* MVVM (planned)

---

# Flavor Behavior

## Flavored Projects

```yaml id="’winiiii321"
flavoring:
  enabled: true
```

FKIT automatically uses:

```bash id="’winiiii322"
--flavor production
```

---

## Non-Flavored Projects

```yaml id="’winiiii323"
flavoring:
  enabled: false
```

FKIT skips Flutter flavor arguments automatically.

Useful for:

* web apps
* simple apps
* dart-define-only workflows

---

# FVM Support

Enable inside:

```yaml id="’winiiii324"
tooling:
  use_fvm: true
```

FKIT automatically uses:

```bash id="’winiiii325"
fvm flutter
fvm dart
```

instead of:

```bash id="’winiiii326"
flutter
dart
```

---

# Common Workflows

## Fresh Project Setup

```bash id="’winiiii327"
fkit init
fkit doctor
fkit get
fkit generate
```

---

## Production APK Build

```bash id="’winiiii328"
fkit build apk production
```

---

## Firebase QA Distribution

```bash id="’winiiii329"
fkit firebase staging --notes="QA build"
```

---

## Setup Android Signing

```bash id="’winiiii330"
fkit signing setup
```

---

# Planned Commands

Future FKIT commands:

```bash id="’winiiii331"
fkit release
fkit deploy
fkit changelog
fkit version
fkit ci
fkit store
```

---

# Best Practices

## Recommended

* Use FVM for teams
* Keep env files separated
* Use flavor-specific Firebase projects
* Validate configuration before release
* Use release notes for Firebase uploads

---

## Avoid

* Sharing keystores in Git
* Hardcoded secrets
* Mixing environments
* Using production Firebase in staging
