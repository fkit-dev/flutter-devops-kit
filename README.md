# Flutter DevOps Kit (FKIT)

A scalable, template-driven Flutter CLI toolkit for project automation, code generation, reusable architecture workflows, builds, Firebase distribution, signing, localization, and developer tooling.

FKIT is designed to reduce repetitive Flutter setup and development tasks while remaining flexible enough to support different project architectures and engineering workflows.

---

# Overview

Flutter DevOps Kit (`fkit`) is a reusable command-line toolkit built for Flutter developers and teams.

Instead of repeatedly configuring project structure, architecture, modules, builds, signing, localization, Firebase distribution, launcher icons, and code generation manually, FKIT provides a unified CLI workflow.

FKIT is installed globally once and configured per Flutter project using:

```text
fkit.yaml
```

The toolkit is designed around three major ideas:

* Project automation
* Template-driven code generation
* Reusable development workflows

FKIT can be used for both existing Flutter projects and newly initialized projects.

---

# Why FKIT?

Flutter projects often require repetitive setup and maintenance tasks such as:

* Creating architecture-specific feature folders
* Generating DTOs, entities, repositories, use cases, BLoCs, and screens
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

## Completed Features

### Global CLI

Install FKIT once and use it across multiple Flutter projects.

```bash
dart pub global activate flutter_devops_kit
```

Run commands using:

```bash
fkit <command>
```

---

### Interactive Project Initialization

Initialize FKIT inside an existing Flutter project:

```bash
fkit init
```

FKIT interactively configures:

* Project name
* Feature path
* FVM usage
* Enabled platforms
* Flavor configuration
* Environment files
* Firebase configuration
* Localization
* Default architecture template

The generated project configuration is stored in:

```text
fkit.yaml
```

---

### Project Configuration

FKIT uses a project-level YAML configuration file.

```text
fkit.yaml
```

Configuration supports:

* Project information
* Flutter tooling
* FVM
* Platforms
* Build configuration
* Entry points
* Flavors
* Environment files
* Firebase
* Localization
* Generator templates

---

### Template-Driven Architecture

FKIT supports architecture templates that define how project code should be generated and maintained.

Templates can configure:

* Feature structure
* Components
* Component groups
* Dependency injection
* Barrel files
* Routing
* Installable modules

Current architecture work includes support for:

```text
bloc_clean
riverpod_clean
```

Template support is designed to expand over time.

---

### Feature Generation

Generate a complete feature:

```bash
fkit feat auth
```

Feature generation follows the selected project template.

Depending on the architecture template, FKIT can generate:

* Data layer
* Domain layer
* Presentation layer
* Dependency injection
* Barrel files
* Architecture-specific files

---

### Component Generation

Generate individual architecture components using:

```bash
fkit make <component> <feature> [name]
```

Examples:

```bash
fkit make dto auth Login
```

```bash
fkit make entity auth User
```

```bash
fkit make mapper auth User
```

```bash
fkit make usecase auth Login
```

```bash
fkit make repository auth
```

```bash
fkit make bloc auth
```

```bash
fkit make screen auth Register
```

FKIT automatically uses the selected architecture template to determine how the component should be generated.

---

### Component Groups

Architecture templates can define groups of related components.

This allows multiple components to be generated together while keeping the generator extensible.

Groups are configured at the template level instead of being hardcoded into the CLI.

---

### Automatic Dependency Injection Maintenance

FKIT can automatically maintain feature-level dependency injection registrations.

For supported templates, generated components are discovered and registered automatically.

Current DI architecture supports template-driven strategies including:

```text
get_it
```

The system is designed to support additional DI strategies in future releases.

Planned strategies include:

* Riverpod
* GetX
* Injectable
* Manual dependency injection

---

### Automatic Barrel File Maintenance

FKIT can automatically maintain architecture barrel files after component generation.

Generated files can be discovered and exported according to template configuration.

This reduces repetitive manual export maintenance.

---

### Router Module

Install routing support using:

```bash
fkit install router
```

The Router module currently provides GoRouter-based routing support.

Features include:

* Route file generation
* Router configuration
* Screen discovery
* Architecture-aware screen location
* Automatic route synchronization
* Automatic import generation
* Duplicate route prevention
* Preservation of existing routes
* FKIT-managed route sections

FKIT can discover screens based on architecture conventions.

Examples include:

```text
presentation/screens/*_screen.dart
```

and architecture-specific view conventions.

After generating a new screen:

```bash
fkit make screen auth ResetPassword
```

FKIT can automatically synchronize the router.

---

### Theme Module

Install a reusable application theme:

```bash
fkit install theme
```

The Theme module provides a reusable Material 3 theme foundation.

The generated module includes support for:

* Application colors
* Application typography
* Theme constants
* Theme state
* Theme management
* Light theme
* Dark theme
* System theme mode

---

### Module Installation System

Install reusable project modules using:

```bash
fkit install <module>
```

Examples:

```bash
fkit install theme
```

```bash
fkit install router
```

```bash
fkit install network
```

The module system supports:

* Template-specific modules
* Module definitions
* Module files
* Required packages
* Required development packages
* Conditional files
* Conditional dependencies
* Interactive module options
* Post-install integration
* Build runner requirements
* Flutter Gen requirements

---

### Conditional Module Options

Modules can ask interactive configuration questions during installation.

For example:

```text
Use Talker for application and network logging? [Y/n]
```

Based on the selected option, FKIT can conditionally:

* Generate files
* Add dependencies
* Add development dependencies
* Configure module integration

This allows modules to remain reusable without forcing every project to use the same packages.

---

### Launcher Icon Utilities

FKIT provides launcher icon utilities through:

```bash
fkit icon
```

Supported workflows include:

```bash
fkit icon generate
```

```bash
fkit icon configure
```

```bash
fkit icon doctor
```

The launcher icon workflow supports:

* Android icons
* iOS icons
* Web icons
* Adaptive icon backgrounds
* Adaptive icon foregrounds
* Adaptive monochrome icons
* iOS alpha removal
* Interactive configuration

---

### Flutter Command Automation

FKIT provides wrappers and workflows around common Flutter development commands.

Available tooling includes:

* Package retrieval
* Formatting
* Analysis
* Automated fixes
* Clean
* Run
* Build
* Code generation
* Watch mode

---

### Code Generation

Run project code generation:

```bash
fkit generate
```

FKIT supports build runner workflows and architecture-generated files.

---

### Build Runner Watch Mode

Run code generation continuously:

```bash
fkit watch
```

Useful during active development with packages such as:

* Freezed
* JSON Serializable
* Riverpod Generator
* Other source generators

---

### Flutter Analysis

Analyze the project:

```bash
fkit analyze
```

---

### Dart Formatting

Format project source code:

```bash
fkit format
```

---

### Automated Dart Fixes

Run automated Dart fixes:

```bash
fkit fix
```

---

### Project Cleaning

Clean the Flutter project:

```bash
fkit clean
```

---

### Package Retrieval

Retrieve Flutter dependencies:

```bash
fkit get
```

---

### Flutter Run Automation

Run Flutter applications using FKIT workflows:

```bash
fkit run
```

The command supports project configuration and flavor-aware workflows.

---

### Build Automation

FKIT supports Flutter build automation for:

* APK
* AAB
* IPA
* Web

Example:

```bash
fkit build apk production
```

```bash
fkit build aab production
```

```bash
fkit build ipa production
```

```bash
fkit build web
```

---

### Flavor Support

FKIT supports flavor-aware project workflows.

Projects can define:

* Development
* Staging
* Production
* Custom flavors

Each flavor can configure:

* Environment files
* Firebase App Distribution IDs
* Firebase options

---

### FVM Support

FKIT supports Flutter Version Management projects.

Configure:

```yaml
tooling:
  use_fvm: true
```

FKIT will use the appropriate Flutter execution workflow for the configured project.

---

### Firebase App Distribution

Upload Flutter builds to Firebase App Distribution.

Example:

```bash
fkit firebase production
```

FKIT supports flavor-specific Firebase App Distribution configuration.

---

### Android Signing Setup

Configure Android signing using:

```bash
fkit signing setup
```

The signing workflow helps automate Android release signing configuration.

---

### Localization

FKIT provides localization configuration and automation.

Project initialization supports:

* ARB directory configuration
* Generated output directory
* Localization output file
* Default locale
* Supported locales

---

### Environment Diagnostics

Validate the project environment:

```bash
fkit doctor
```

FKIT can inspect project tooling and identify configuration problems.

---

### Configuration Validation

Validate FKIT project configuration:

```bash
fkit validate
```

---

### Extension Utilities

FKIT includes extension-related generation and automation workflows.

```bash
fkit extension
```

---

# Ongoing Development

## Network Module

The Network module is currently under active development.

Install using:

```bash
fkit install network
```

The module is being designed as a reusable Dio-based networking foundation.

Current implementation includes:

* Dio configuration
* API configuration
* Dio factory
* Base API service
* Network API service
* Generic typed response parsing
* Object response mapping
* List response mapping
* Paginated response mapping
* Result mapping
* API response extensions
* Base response model
* Pagination model
* Paginated result model
* Result model
* Result message model
* Application exception hierarchy
* Error models
* Dio failure handling
* Network connectivity monitoring
* Network interceptor
* Authentication interceptor foundation
* Optional Talker logging
* Conditional dependencies
* Module integration infrastructure

Current development is focused on:

* Dependency injection integration
* Module integration strategies
* Network dependency registration
* Application-level integration
* Architecture-specific integration

---

# Future Updates

FKIT is being developed incrementally.

Planned updates include the following areas.

## Module Integration Improvements

Future releases will improve module installation and integration.

Planned improvements include:

* Generic module integration pipelines
* Removal of command-specific integration logic
* Architecture-specific integrators
* Automatic root dependency registration
* Module lifecycle hooks
* Post-install maintainers
* Module upgrade support
* Module version tracking

---

## Dependency Injection Strategies

Planned support includes:

* Riverpod
* GetX
* Injectable
* Manual dependency injection

The goal is to allow architecture templates to define their own DI strategy without hardcoding framework-specific behavior into FKIT commands.

---

## Network Module Improvements

Future Network module updates may include:

* Token refresh support
* Retry strategies
* Device information headers
* Custom application headers
* Request encryption
* Response encryption
* Certificate pinning
* Web security interceptors
* Configurable authentication providers
* Network module diagnostics

Project-specific functionality will remain optional rather than being forced into the default generated network layer.

---

## Storage Module

A reusable storage module is planned.

Potential support includes:

* Secure storage
* Shared preferences
* Hive
* Storage abstractions
* Architecture-specific registration
* Authentication token providers

---

## Firebase Module Improvements

Planned Firebase workflows include:

* Firebase initialization
* Firebase configuration generation
* Firebase Authentication setup
* Firebase Messaging setup
* Crashlytics setup
* Analytics setup

---

## Deployment Automation

Planned deployment workflows include:

* Fastlane integration
* Google Play Store deployment
* Apple App Store deployment
* Web deployment automation
* Firebase Hosting
* Release pipelines

---

## Release Management

Planned release tooling includes:

* Version management
* Git tagging
* Changelog generation
* Release notes
* Automated release workflows

---

## CI/CD

Future versions may provide reusable CI/CD templates for:

* GitHub Actions
* GitLab CI
* Bitbucket Pipelines

Potential workflows include:

* Flutter analysis
* Testing
* Android builds
* iOS builds
* Web builds
* Firebase distribution
* Store deployment

---

## Notifications

Potential automation integrations include:

* Slack notifications
* Discord notifications
* Microsoft Teams notifications

---

## Testing Support

Future generator improvements may include:

* Unit test generation
* Widget test generation
* Repository tests
* Use case tests
* BLoC tests
* Mock generation

---

## Module Marketplace and Custom Modules

Long-term FKIT development may include support for:

* Custom modules
* External module sources
* Team-specific modules
* Private module repositories
* Shared architecture templates

---

# Installation

## Requirements

Before installing FKIT, ensure the following tools are available:

* Flutter SDK
* Dart SDK
* Git

Verify Flutter:

```bash
flutter doctor
```

Verify Dart:

```bash
dart --version
```

---

## Install Globally

Install FKIT from pub.dev:

```bash
dart pub global activate flutter_devops_kit
```

---

# PATH Configuration

After global activation, the Dart global executable directory must be available in your system `PATH`.

---

## macOS / Linux — ZSH

Run:

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.zshrc
source ~/.zshrc
```

---

## macOS / Linux — Bash

Run:

```bash
echo 'export PATH="$PATH:$HOME/.pub-cache/bin"' >> ~/.bashrc
source ~/.bashrc
```

---

## Windows

After installing FKIT globally:

```powershell
dart pub global activate flutter_devops_kit
```

Dart global executables are typically installed in:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

This directory must be added to your Windows user `Path`.

### Add FKIT to PATH using Windows Settings

1. Open the Start menu.
2. Search for `Environment Variables`.
3. Select `Edit the system environment variables`.
4. Select `Environment Variables`.
5. Under `User variables`, select `Path`.
6. Select `Edit`.
7. Select `New`.
8. Add:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

9. Save the changes.
10. Close and reopen PowerShell, Command Prompt, Windows Terminal, or your IDE terminal.

Verify the installation:

```powershell
fkit help
```

---

## Windows PowerShell PATH Setup

The Dart global executable directory can also be added to the user PATH using PowerShell.

```powershell
$pubCacheBin = "$env:LOCALAPPDATA\Pub\Cache\bin"
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

if ($currentPath -notlike "*$pubCacheBin*") {
    [Environment]::SetEnvironmentVariable(
        "Path",
        "$currentPath;$pubCacheBin",
        "User"
    )
}
```

Close and reopen the terminal after running the command.

Then verify:

```powershell
fkit help
```

---

## Windows Troubleshooting

If PowerShell reports:

```text
fkit is not recognized as the name of a cmdlet
```

verify that FKIT was activated:

```powershell
dart pub global list
```

Then verify that the Pub Cache executable directory exists:

```powershell
Test-Path "$env:LOCALAPPDATA\Pub\Cache\bin"
```

Check whether the executable is available:

```powershell
Get-ChildItem "$env:LOCALAPPDATA\Pub\Cache\bin"
```

Restart the terminal after changing environment variables.

If Flutter is managed using FVM, ensure FVM itself is also correctly installed and available in `PATH`.

---

# Verify Installation

Run:

```bash
fkit help
```

You can also validate your environment using:

```bash
fkit doctor
```

---

# Quick Start

## 1. Open a Flutter Project

```bash
cd my_flutter_project
```

---

## 2. Initialize FKIT

```bash
fkit init
```

This generates:

```text
fkit.yaml
```

---

## 3. Validate the Environment

```bash
fkit doctor
```

---

## 4. Generate a Feature

```bash
fkit feat auth
```

---

## 5. Generate a Component

```bash
fkit make screen auth Login
```

---

## 6. Install a Module

```bash
fkit install theme
```

---

## 7. Build the Application

```bash
fkit build apk production
```

---

## 8. Upload to Firebase

```bash
fkit firebase production
```

---

# Example `fkit.yaml`

```yaml
# ============================================================
# FKIT CONFIGURATION
# ============================================================

fkit:
  version: 0.1.1

# ============================================================
# PROJECT
# ============================================================

project_name: sample_project

# ============================================================
# TOOLING
# ============================================================

tooling:
  use_fvm: false

# ============================================================
# PLATFORMS
# ============================================================

platforms:
  android: true
  ios: true
  web: true

# ============================================================
# BUILD
# ============================================================

build:
  debug_info: ./debug-info
  obfuscate: true

# ============================================================
# ENTRY POINT
# ============================================================

entry:
  main: lib/main.dart

# ============================================================
# FLAVORING
# ============================================================

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

# ============================================================
# FIREBASE
# ============================================================

firebase:
  tester_group: internal-testers

# ============================================================
# LOCALIZATION
# ============================================================

localization:
  enabled: true

  arb_dir: lib/l10n

  output_dir: lib/gen/l10n

  output_file: app_localizations.dart

  default_locale: en

  locales:
    - en

# ============================================================
# GENERATOR
# ============================================================

generator:
  default_template: bloc_clean
  feature_path: lib/features
```

---

# Core Commands

| Command | Description |
| --- | --- |
| `fkit help` | Show available commands |
| `fkit init` | Initialize FKIT configuration |
| `fkit doctor` | Validate the development environment |
| `fkit validate` | Validate FKIT configuration |
| `fkit get` | Retrieve Flutter dependencies |
| `fkit clean` | Clean the Flutter project |
| `fkit analyze` | Analyze Dart and Flutter code |
| `fkit format` | Format project source code |
| `fkit fix` | Apply automated Dart fixes |
| `fkit run` | Run the Flutter application |
| `fkit build` | Build Flutter applications |
| `fkit firebase` | Upload builds to Firebase App Distribution |
| `fkit signing` | Configure Android signing |
| `fkit generate` | Run code generation |
| `fkit watch` | Run code generation in watch mode |
| `fkit feat` | Generate an architecture feature |
| `fkit make` | Generate an architecture component |
| `fkit install` | Install a reusable project module |
| `fkit icon` | Configure and generate launcher icons |
| `fkit l10n` | Manage localization workflows |
| `fkit extension` | Extension utilities |

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