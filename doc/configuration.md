# FKIT Configuration Guide

This document explains how to configure Flutter DevOps Kit (`fkit`) using:

```bash
fkit.yaml
```

Every Flutter project using FKIT must contain this file in the project root.

---

# Basic Structure

Example:

```yaml
fkit:
  version: 0.1.1

project_name: my_app

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
  default: development

flavors:
  - development
  - staging
  - production

environment:
  enabled: true
  configurations:
    development:
      file: env/development.json
    staging:
      file: env/staging.json
    production:
      file: env/production.json

firebase:
  enabled: false
  tester_group: internal-testers
  configurations: {}

generator:
  feature_dir: lib/features
  default_template: bloc_clean

localization:
  enabled: false
  arb_dir: lib/l10n
  template: app_en.arb
  output_dir: lib/gen/l10n
  output_file: app_localizations.dart
  default_locale: en
  locales:
    - en
```

---

# Root Configuration

## `project_name`

Project identifier.

```yaml
project_name: my_app
```

Used internally for project metadata and future automation support.

---

# Tooling Configuration

## `tooling.use_fvm`

Enable or disable FVM support.

```yaml
tooling:
  use_fvm: true
```

When enabled, FKIT automatically uses:

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

# Platform Configuration

## `platforms`

Enable supported platforms.

```yaml
platforms:
  android: true
  ios: true
  web: true
```

Used for:

* platform validation
* future deployment workflows
* build restrictions

---

# Build Configuration

## `build.debug_info`

Directory for obfuscation debug symbols.

```yaml
build:
  debug_info: ./debug-info
```

Used during release builds.

---

## `build.obfuscate`

Enable Dart code obfuscation.

```yaml
build:
  obfuscate: true
```

Applied automatically during production builds.

---

# Entry Configuration

## `entry.main`

Flutter entry point.

```yaml
entry:
  main: lib/main.dart
```

Used for:

* run commands
* build commands
* future multi-entry support

---

# Flavor Configuration

## `flavoring.enabled`

Controls whether Flutter flavors are used.

### Flavored Project

```yaml
flavoring:
  enabled: true
```

FKIT will use:

```bash
--flavor production
```

during builds.

---

### Non-Flavored Project

```yaml
flavoring:
  enabled: false
```

FKIT skips Flutter flavor arguments automatically.

Useful for:

* simple apps
* web-only apps
* dart-define-based environments

---

# Flavor Targets

## `flavoring.default`

Default flavor used when no flavor is provided.

```yaml
flavoring:
  enabled: true
  default: production

flavors:
  - development
  - staging
  - production
```

Example:

```bash
fkit build web
```

automatically uses:

```yaml
production
```

---

# Environment Configuration

## `environment.configurations`

Environment file used with:

```bash
--dart-define-from-file
```

Example:

```yaml
environment:
  enabled: true
  configurations:
    development:
      file: env/development.json
```

---

# Firebase Configuration

## `firebase.configurations`

Firebase App Distribution App IDs and FlutterFire options files are configured
per target and platform.

Example:

```yaml
firebase:
  enabled: true
  tester_group: internal-testers
  configurations:
    production:
      android:
        app_id: 1:1234567890:android:abcdef
        options: lib/firebase_options_production.dart
      ios:
        app_id: 1:1234567890:ios:abcdef
        options: lib/firebase_options_production.dart
```

Used for:

* validation
* future deployment integrations
* Firebase environment management

---

# Firebase Tester Group

## `firebase.tester_group`

Default Firebase App Distribution tester group.

```yaml
firebase:
  tester_group: internal-testers
```

Used automatically during Firebase uploads.

---

# Generator Configuration

## `generator.default_template`

Default feature scaffolding architecture.

Example:

```yaml
generator:
  default_template: bloc_clean
```

Template status:

* bloc_clean (current, production-ready)
* riverpod_clean (planned)
* mvvm (planned)
* provider_clean (planned)
* getx_clean (planned)

---

# Flavored Project Example

```yaml
flavoring:
  enabled: true
  default: production

flavors:
  - development
  - staging
  - production

environment:
  enabled: true
  configurations:
    development:
      file: env/development.json
    staging:
      file: env/staging.json
    production:
      file: env/production.json
```

Build example:

```bash
fkit build apk production
```

---

# Non-Flavored Project Example

```yaml
flavoring:
  enabled: false
  default: main

flavors:
  - main

environment:
  enabled: true
  configurations:
    main:
      file: env/env.json
```

Build example:

```bash
fkit build web
```

FKIT automatically skips:

```bash
--flavor
```

for non-flavored projects.

---

# Validation

Validate configuration:

```bash
fkit validate
```

Checks:

* entry file
* env files
* Firebase files
* flavor consistency

---

# Best Practices

## Recommended

* Keep flavor names consistent
* Store env files inside `/env`
* Use separate Firebase configs per environment
* Enable obfuscation for production
* Use FVM for team consistency

---

## Avoid

* Hardcoded secrets
* Missing env files
* Sharing signing keys in Git
* Mixing production & staging Firebase projects

---

# Future Scope

Planned configuration extensions:

* deployment providers
* CI/CD settings
* release channels
* build profiles
* Git workflows
* store deployment configs
