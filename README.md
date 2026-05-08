# Flutter DevOps Kit (FKIT)

A scalable Flutter DevOps CLI for build automation, flavor management, Firebase distribution, and reusable engineering workflows.

---

# Overview

Flutter DevOps Kit (`fkit`) is a reusable command-line automation toolkit built for Flutter projects.

It helps automate:

* Flutter cleanup & setup
* Dependency management
* Code formatting & analysis
* Flavor-based builds
* Firebase App Distribution
* iOS & Android workflows
* Feature scaffolding
* Project tooling
* Future CI/CD workflows

The CLI is globally installed once and configured per project using `fkit.yaml`.

---

# Features

## Current Features

* Global CLI installation
* Project-based YAML configuration
* Flutter & Dart command automation
* Environment diagnostics
* Dynamic flavor support
* FVM support
* Code quality commands
* Config-driven architecture

## Planned Features

* APK/AAB/IPA builds
* Firebase App Distribution
* Feature scaffolding
* Fastlane integration
* Play Store deployment
* App Store deployment
* Release automation
* Git tagging
* Changelog generation
* CI/CD templates

---

# Installation

## 1. Clone Repository

```bash
git clone https://github.com/TejasD36/flutter-devops-kit.git
```

---

## 2. Navigate to Project

```bash
cd flutter_devops_kit
```

---

## 3. Activate CLI Globally

```bash
dart pub global activate --source path .
```

---

## 4. Add Dart Global Bin to PATH (macOS/Linux)

Add this to your shell config:

### ZSH

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

### Bash

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

---

## 5. Verify Installation

```bash
fkit help
```

Expected output:

```bash
Flutter DevOps Kit

Available Commands:
help
doctor
clean
get
fix
analyze
format
```

---

# Project Configuration

Each Flutter project using `fkit` must contain:

```bash
fkit.yaml
```

inside the project root.

Example:

```bash
my_flutter_project/
├── android/
├── ios/
├── lib/
├── env/
├── pubspec.yaml
└── fkit.yaml
```

---

# Example `fkit.yaml`

```yaml
project_name: sample_project

tooling:
  use_fvm: false

build:
  debug_info: ./debug-info
  obfuscate: true

entry:
  main: lib/main.dart

flavors:
  default: development

  development:
    env: env/development.json
    firebase_app_id: YOUR_DEV_FIREBASE_APP_ID

  staging:
    env: env/staging.json
    firebase_app_id: YOUR_STAGING_FIREBASE_APP_ID

  production:
    env: env/production.json
    firebase_app_id: YOUR_PRODUCTION_FIREBASE_APP_ID

firebase:
  tester_group: internal-testers
```

---

# Usage

Run all commands from inside your Flutter project.

Example:

```bash
cd my_flutter_project
fkit clean
```

---

# Available Commands

## Help

```bash
fkit help
```

Displays all available commands.

---

## Doctor

```bash
fkit doctor
```

Checks required tools:

* Flutter
* Dart
* Firebase CLI
* CocoaPods
* Java
* Git

---

## Clean Flutter Project

```bash
fkit clean
```

Equivalent to:

```bash
flutter clean
```

Automatically respects FVM configuration.

---

## Get Dependencies

```bash
fkit get
```

Equivalent to:

```bash
flutter pub get
```

---

## Apply Dart Fixes

```bash
fkit fix
```

Equivalent to:

```bash
dart fix --apply
```

---

## Analyze Project

```bash
fkit analyze
```

Equivalent to:

```bash
dart analyze lib
```

---

## Format Project

```bash
fkit format
```

Equivalent to:

```bash
dart format lib
```

---

# FVM Support

Enable FVM inside:

```yaml
fkit.yaml
```

```yaml
tooling:
  use_fvm: true
```

Then commands automatically use:

```bash
fvm flutter
fvm dart
```

instead of:

```bash
flutter
dart
```

---

# Architecture

## Global CLI

Installed once globally:

```bash
fkit
```

---

## Per-Project Config

Each project contains:

```bash
fkit.yaml
```

This allows the same CLI to work across multiple projects with different:

* Flavors
* Firebase configs
* FVM settings
* Build setups
* Environment files

---

# Recommended Project Structure

```bash
my_flutter_project/
├── android/
├── ios/
├── lib/
├── env/
│   ├── development.json
│   ├── staging.json
│   └── production.json
├── fkit.yaml
└── pubspec.yaml
```

---

# Development

## Run CLI Locally

```bash
dart run bin/fkit.dart help
```

---

## Re-Activate Global CLI After Changes

```bash
dart pub global activate --source path .
```

---

# Planned Command Roadmap

## General

```bash
fkit reset
fkit prepare
fkit watch
fkit build-runner
```

## Build System

```bash
fkit run development
fkit build apk development
fkit build aab production
fkit build ipa staging
```

## Firebase Distribution

```bash
fkit firebase development
fkit firebase production --notes="QA build"
```

## Feature Scaffolding

```bash
fkit feat auth
```

## Release Automation

```bash
fkit release production
```

---

# Design Principles

* Config-driven architecture
* No project-specific hardcoding
* Reusable global tooling
* Flavor-aware workflows
* Scalable command system
* Future CI/CD compatibility
* FVM compatibility

---

# Contributing

Contributions, improvements, and automation ideas are welcome.

Potential contribution areas:

* Build automation
* CI/CD templates
* Store deployment
* Fastlane integration
* Feature generators
* Documentation improvements
* Testing

---

# License

MIT License

---

# Author

Built with ❤️ for scalable Flutter engineering workflows.
