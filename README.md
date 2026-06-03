# Flutter DevOps Kit (FKIT)

A scalable Flutter DevOps CLI toolkit for build automation, Firebase distribution, Android signing setup, feature scaffolding, and reusable engineering workflows.

---

# Overview

Flutter DevOps Kit (`fkit`) is a reusable command-line automation toolkit built for Flutter projects.

It helps automate:

* Flutter project setup
* Flavor-based builds
* Firebase App Distribution
* Android signing configuration
* Code generation workflows
* Feature scaffolding
* Flutter/Dart tooling
* Multi-project DevOps workflows

FKIT is installed globally once and configured per project using `fkit.yaml`.

---

# Features

## Current Features

* Global CLI installation
* Project-based YAML configuration
* Flutter & Dart command automation
* APK / AAB / IPA / Web builds
* Firebase App Distribution
* Android signing setup
* Environment diagnostics
* Flavor-aware workflows
* FVM support
* Feature scaffolding
* Code quality automation
* Interactive project initialization
* Config validation

## Planned Features

* Fastlane integration
* Play Store deployment
* App Store deployment
* Web deployment automation
* Release pipelines
* Git tagging
* Changelog generation
* CI/CD templates
* Slack / Discord notifications

---

# Installation

## Install Globally

```bash
dart pub global activate flutter_devops_kit
```

---

## Add Dart Global Bin to PATH

### macOS / Linux (ZSH)

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

### macOS / Linux (Bash)

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

---

## Verify Installation

```bash
fkit help
```

---

# Quick Start

## 1. Initialize FKIT

Run inside your Flutter project:

```bash
fkit init
```

This generates:

```bash
fkit.yaml
```

---

## 2. Validate Environment

```bash
fkit doctor
```

---

## 3. Build APK

```bash
fkit build apk production
```

---

## 4. Upload to Firebase

```bash
fkit firebase production
```

---

# Example `fkit.yaml`

```yaml
project_name: sample_project

tooling:
  use_fvm: false

platforms:
  android: true
  ios: true
  web: true

build:
  debug_info: ./debug-info
  obfuscate: true

entry:
  main: lib/main.dart

flavoring:
  enabled: true

flavors:
  default: production

  development:
    env: env/development.json

    firebase:
      app_distribution_id: YOUR_DEV_APP_ID

      options:
        android: lib/firebase_options_development.dart
        ios: lib/firebase_options_development.dart
        web: lib/firebase_options_development.dart

  production:
    env: env/production.json

    firebase:
      app_distribution_id: YOUR_PROD_APP_ID

      options:
        android: lib/firebase_options_production.dart
        ios: lib/firebase_options_production.dart
        web: lib/firebase_options_production.dart

firebase:
  tester_group: internal-testers
```

---

# Core Commands

| Command                     | Description              |
| --------------------------- | ------------------------ |
| `fkit help`                 | Show available commands  |
| `fkit doctor`               | Validate environment     |
| `fkit init`                 | Initialize FKIT config   |
| `fkit build apk production` | Build APK                |
| `fkit build web`            | Build web app            |
| `fkit firebase production`  | Upload build to Firebase |
| `fkit signing setup`        | Setup Android signing    |
| `fkit feat auth`            | Generate feature module  |

---

# Documentation

Detailed documentation:

* `docs/configuration.md`
* `docs/commands.md`
* `docs/firebase.md`
* `docs/signing.md`
* `docs/feature-scaffolding.md`
* `docs/roadmap.md`

---

# Architecture

FKIT follows:

* Config-driven architecture
* Reusable global tooling
* Multi-project support
* Flavor-aware workflows
* Future CI/CD scalability

---

# Recommended Project Structure

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

# Development

Run locally:

```bash
dart run bin/fkit.dart help
```

Re-activate global CLI after changes:

```bash
dart pub global activate --source path .
```

---

# Contributing

Contributions and automation ideas are welcome.

Areas of contribution:

* Build automation
* Deployment workflows
* CI/CD templates
* Feature generators
* Documentation
* Testing

---

# License

MIT License

---

# Author

Built with ❤️ for scalable Flutter engineering workflows.
