<p align="center">
  <img src="https://raw.githubusercontent.com/fkit-dev/flutter-devops-kit/main/assets/branding/fkit_banner.png" alt="FKIT Banner" width="100%">
</p>

<p align="center">

<a href="https://pub.dev/packages/flutter_devops_kit">
<img src="https://img.shields.io/pub/v/flutter_devops_kit.svg" alt="Pub Version">
</a>

<a href="https://pub.dev/packages/flutter_devops_kit">
<img src="https://img.shields.io/pub/likes/flutter_devops_kit" alt="Pub Likes">
</a>

<a href="https://pub.dev/packages/flutter_devops_kit">
<img src="https://img.shields.io/pub/points/flutter_devops_kit" alt="Pub Points">
</a>

<a href="LICENSE">
<img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</a>

<a href="https://github.com/fkit-dev/flutter-devops-kit">
<img src="https://img.shields.io/github/stars/fkit-dev/flutter-devops-kit?style=social" alt="GitHub Stars">
</a>

</p>

<p align="center">
<b>The modern Flutter CLI for project scaffolding, automation, code generation, builds, flavors, Firebase App Distribution, and developer productivity.</b>
</p>

<p align="center">
🚀 Scaffold &nbsp; • &nbsp;
⚙️ Automate &nbsp; • &nbsp;
🏗️ Generate &nbsp; • &nbsp;
📦 Build &nbsp; • &nbsp;
🔥 Deploy
</p>

---

# ⚡ Installation

```bash
dart pub global activate flutter_devops_kit
```

Verify the installation:

```bash
fkit doctor
```

---

# 🚀 Quick Start

```bash
# Check your development environment
fkit doctor

# Initialize FKIT inside your Flutter project
fkit init

# Generate a new feature
fkit feat auth --no-build-runner

# Run setup without overwrite prompts
fkit setup --yes
```

---

# ✨ Features

- 🏗️ Project initialization & setup
- 📂 Feature & module code generation
- 🎯 Clean Architecture templates
- 🧩 Template-driven BLoC Clean Architecture generation
- 📦 APK, AAB & IPA build automation
- 🔥 Firebase App Distribution
- 🎨 Multi-flavor project management
- 📱 Launcher icon & asset generation
- 🌍 Localization support
- ⚡ FVM integration
- 🛠️ Developer productivity commands
- 🔄 Reusable template system

---

# 📖 Overview

**FKIT (Flutter DevOps Kit)** is a reusable command-line toolkit built for Flutter developers, teams, and organizations. The currently production-ready template is `bloc_clean`; Riverpod Clean and MVVM templates are planned.

Instead of repeatedly configuring project structure, architecture, modules, builds, signing, localization, launcher icons, Firebase App Distribution, and code generation manually, FKIT provides a unified, scalable, and consistent CLI workflow.

Install FKIT once, configure your project using a simple `fkit.yaml` file, and automate the repetitive parts of Flutter development.

FKIT is built around four core principles:

- ⚡ **Project Automation** — Eliminate repetitive Flutter setup tasks.
- 🏗️ **Template-Driven Code Generation** — Generate production-ready architecture and boilerplate.
- 🚀 **Build & Release Automation** — Simplify APK, AAB, IPA builds, flavors, signing, and Firebase App Distribution.
- 🛠️ **Developer Productivity** — Standardize workflows across personal, team, and enterprise projects.

Whether you're starting a brand-new Flutter application or maintaining a large production codebase, FKIT helps you automate repetitive tasks, enforce consistency, and accelerate development.

---
# Installation

FKIT can be installed globally using the Dart package manager.

## Prerequisites

Before installing FKIT, make sure the following are available:

* Flutter SDK
* Dart SDK
* Git

Verify your Flutter and Dart installations:

```bash
flutter --version
dart --version
```

---

## macOS / Linux

Install FKIT globally:

```bash
dart pub global activate flutter_devops_kit
```

Add the Dart global executable directory to your `PATH`.

### Zsh

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

### Bash

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

Verify the installation:

```bash
fkit help
```

---

## Windows

Install FKIT globally using PowerShell or Command Prompt:

```bash
dart pub global activate flutter_devops_kit
```

The Dart global executable directory is typically:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

Add this directory to the Windows `PATH` environment variable.

### Using Windows Settings

1. Open **System Properties**.
2. Select **Advanced**.
3. Select **Environment Variables**.
4. Under **User variables**, select the `Path` variable.
5. Select **Edit**.
6. Select **New**.
7. Add:    `%LOCALAPPDATA%\Pub\Cache\bin`
8. Save the changes and restart your terminal.

Verify the installation:

```bash
fkit help
```

---

## Update FKIT

To update to the latest published version:

```bash
dart pub global activate flutter_devops_kit
```

---

## Uninstall FKIT

To remove FKIT:

```bash
dart pub global deactivate flutter_devops_kit
```

---

## Verify Installation

After installation, run:

```bash
fkit help
```

You can also verify your development environment with:

```bash
fkit doctor
```

Once installed, FKIT is available globally and can be used inside any Flutter project.

# Why FKIT?

Flutter projects often require repetitive setup and maintenance tasks such as:

* Creating architecture-specific feature folders
* Generating DTOs, entities, repositories, use cases, BLoC's, and screens
* Maintaining dependency injection registrations
* Maintaining application routes
* Installing reusable project modules
* Configuring launcher icons
* Running code generation
* Managing Flutter and FVM commands
* Building APK, AAB, IPA, and Web applications
* Managing flavors
* Uploading builds to Firebase App Distribution
* Configuring Android signing
* Managing localization workflows
* Running formatting, analysis, and automated fixes

FKIT provides a single CLI interface for these workflows.

```bash
fkit <command>
```

---

# Version

Current release:

```text
0.1.1
```

FKIT is under active development.

The current release focuses on building the foundation for a scalable Flutter CLI ecosystem, including template-driven generation, reusable modules, project automation, and architecture-aware maintenance.

---

# Features

## Available Features

### Project Setup & Configuration

* Global CLI installation
* Interactive project initialization
* YAML-based project configuration
* Template-driven project setup
* Automated project bootstrap generation
* Environment diagnostics and validation
* FVM support
* Multi-platform project configuration

### Code Generation

* Feature-first architecture scaffolding
* Feature generation with `fkit feat`
* Component generation with `fkit make`
* Resource generation workflows
* Template-driven generators
* Automatic barrel file maintenance
* Automatic dependency injection maintenance
* Build Runner integration

### Reusable Modules

* Module installation with `fkit install`
* Template-defined module configuration
* Interactive module options
* Conditional file generation
* Conditional package dependencies
* Automated dependency management
* Generic and DI-specific module integrations

Currently available modules:

* Theme
* Router
* Network

### Routing

* GoRouter module generation
* Automatic route discovery
* Automatic route synchronization
* Existing route detection
* Duplicate route prevention
* Preservation of manually customized routes
* Automatic route import maintenance

### Network Layer

* Dio-based API service
* Typed API responses
* Generic response mappers
* Object and list response mapping
* Pagination support
* API response extensions
* Centralized failure handling
* Dio exception mapping
* Network connectivity monitoring
* Network interceptor
* Authentication interceptor
* Optional Talker application and network logging

### Localization

* Localization setup
* ARB file generation
* `l10n.yaml` generation
* Localization validation
* Localization diagnostics
* Automatic Flutter localization dependency configuration

### Build & Distribution

* APK builds
* Android App Bundle builds
* IPA builds
* Flutter Web builds
* Flavor-aware workflows
* Firebase App Distribution
* Android signing setup
* Dart code obfuscation support

## In Development

* Additional reusable modules
* Additional architecture templates
* Improved project setup customization
* Expanded automated test coverage
* Additional module integration strategies

## Planned Features

* Fastlane integration
* Play Store deployment
* App Store deployment
* Web deployment automation
* Release pipelines
* Git tagging
* Changelog generation
* CI/CD templates
* Slack and Discord notifications

---

# Quick Start

## 1. Initialize FKIT

Run inside your Flutter project:

```bash
fkit init
```

This creates the FKIT project configuration and allows you to configure project settings and select the default architecture template.

---

## 2. Prepare Project Prerequisites

Before running the complete project setup, configure any project-specific prerequisites required by your application.

Examples include:

* Firebase configuration
* Flutter flavors
* Environment files
* Platform-specific configuration

---

## 3. Set up the Project

```bash
fkit setup
```

The setup command reads the selected architecture template and automatically performs the configured project setup workflow.

Depending on the selected template, FKIT can:

* Install reusable modules
* Add required dependencies
* Generate configured features
* Synchronize dependency injection
* Synchronize application routes
* Generate project bootstrap files
* Configure project-level requirements
* Run dependency synchronization
* Execute required code generation

For example, a template may define:

```yaml
setup:
  modules:
    - theme
    - router
    - network

  features:
    - auth

  bootstrap:
    enabled: true

    app:
      template: bootstrap/app.dart.tpl
      output: lib/app/view/app.dart

    main:
      template: bootstrap/main.dart.tpl
      output: lib/main.dart
```

Running:

```bash
fkit setup
```

can transform a fresh Flutter project into a structured, architecture-ready starting point.

---

## 4. Validate the Environment

```bash
fkit doctor
```

---

## 5. Generate Additional Features

```bash
fkit feat profile
```

---

## 6. Generate Feature Components

```bash
fkit make screen auth login
```

---

## 7. Install Additional Modules

```bash
fkit install network
```

---

## 8. Build the Application

```bash
fkit build apk production
```

---

## 9. Upload to Firebase App Distribution

```bash
fkit firebase production
```

---

# Core Commands

| Command                       | Description                                                |
|-------------------------------|------------------------------------------------------------|
| `fkit help`                   | Show available commands                                    |
| `fkit doctor`                 | Validate the development environment                       |
| `fkit init`                   | Initialize FKIT configuration                              |
| `fkit setup`                  | Setup the project using the selected architecture template |
| `fkit config`                 | Display the currently loaded FKIT configuration            |
| `fkit feat auth`              | Generate a complete feature module                         |
| `fkit make screen auth login` | Generate a feature component                               |
| `fkit install theme`          | Install the theme module                                   |
| `fkit install router`         | Install the router module                                  |
| `fkit install network`        | Install the network module                                 |
| `fkit l10n setup`             | Setup Flutter localization                                 |
| `fkit l10n generate`          | Generate localization files                                |
| `fkit l10n doctor`            | Validate localization configuration                        |
| `fkit build apk production`   | Build an APK                                               |
| `fkit build aab production`   | Build an Android App Bundle                                |
| `fkit build ipa production`   | Build an IPA                                               |
| `fkit build web production`   | Build the Flutter Web application                          |
| `fkit firebase production`    | Upload a build to Firebase App Distribution                |
| `fkit signing setup`          | Setup Android signing                                      |

---

# Template-Driven Architecture

FKIT uses reusable architecture templates to define how projects, features, components, modules, routing, dependency injection, and project setup workflows are generated.

The currently available production-ready template is:

* `bloc_clean` — Feature-first Clean Architecture using `flutter_bloc`

Planned templates: `riverpod_clean`, `mvvm`, `provider_clean`, and `getx_clean`.

Use `--yes` or `--force` with setup, module installation, feature generation,
component generation, and localization generation to overwrite without prompts.
Use `--no-build-runner` with feature and component generation when codegen will
be run separately.

Generated feature files assume the selected template's declared runtime and
development dependencies have been added to `pubspec.yaml`.

Templates can define:

* Feature structure
* Components
* Component groups
* Barrel files
* Dependency injection
* Routing
* Reusable modules
* Project requirements
* Project setup workflows
* Application bootstrap files

This architecture allows FKIT to support additional project structures and state-management approaches in future releases without coupling generators directly to a single architecture.

---

# Reusable Modules

FKIT modules provide reusable project-level functionality that can be installed independently.

```bash
fkit install <module>
```

Available modules include:

```bash
fkit install theme
fkit install router
fkit install network
```

Modules can define:

* Generated files
* Required dependencies
* Development dependencies
* Interactive configuration options
* Conditional files
* Conditional dependencies
* Build Runner requirements
* Template and DI-specific integrations

This allows modules to remain reusable while adapting their integration behavior to the selected architecture template.
---

# Architecture

FKIT follows a configuration-driven and template-driven architecture.

The CLI is organized around:

```text
Commands
    ↓
Services
    ↓
Templates
    ↓
Generators
    ↓
Resolvers
    ↓
Maintainers
    ↓
Integrators
```

Major architectural concepts include:

* Commands for user-facing workflows
* Services for reusable application logic
* Templates for architecture-specific behavior
* Generators for file creation
* Resolvers for project discovery
* Maintainers for existing code synchronization
* Integrators for module and architecture integration

This structure is designed to prevent architecture-specific logic from being hardcoded directly into CLI commands.

---

# Recommended Flutter Project Structure

A configured Flutter project may look like:

```text
my_flutter_project/
├── android/
├── ios/
├── web/
├── lib/
│   ├── app/
│   ├── core/
│   └── features/
├── env/
├── pubspec.yaml
└── fkit.yaml
```

The exact project structure depends on the selected FKIT architecture template.

---

# Development

Clone the FKIT repository and retrieve dependencies:

```bash
dart pub get
```

Run FKIT locally:

```bash
dart run bin/fkit.dart help
```

Activate the local package globally:

```bash
dart pub global activate --source path .
```

After making CLI changes, reactivate the package:

```bash
dart pub global activate --source path .
```

Run FKIT inside a test Flutter project:

```bash
fkit help
```

---

# Publishing

Before publishing a new FKIT version:

```bash
dart format .
```

```bash
dart analyze
```

```bash
dart test
```

Run a dry publish:

```bash
dart pub publish --dry-run
```

If validation succeeds:

```bash
dart pub publish
```

---

# Project Status

FKIT is under active development.

The `0.1.x` releases focus on establishing the core architecture, template system, generators, maintainers, reusable modules, and project automation foundation.

Breaking changes may occur while the architecture evolves toward a stable release.

---

# Contributing

Contributions, bug reports, architecture templates, modules, and automation ideas are welcome.

Areas of contribution include:

* Build automation
* Deployment workflows
* Architecture templates
* Module development
* Feature generators
* Maintainers
* Integrators
* CI/CD templates
* Documentation
* Testing

---

# License

MIT License

---

# Author

Built with ❤️ for scalable Flutter engineering workflows.
