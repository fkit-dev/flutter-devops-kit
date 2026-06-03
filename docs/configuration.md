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

generator:
  default_template: riverpod_clean
```

---

# Root Configuration

## `project_name`

Project identifier.

```yaml
project_name: scoreloan
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

# Flavors

## `flavors.default`

Default flavor used when no flavor is provided.

```yaml
flavors:
  default: production
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

# Flavor Environment

## `env`

Environment file used with:

```bash
--dart-define-from-file
```

Example:

```yaml
development:
  env: env/development.json
```

---

# Firebase Configuration

## `firebase.app_distribution_id`

Firebase App Distribution App ID.

Example:

```yaml
firebase:
  app_distribution_id: 1:1234567890:android:abcdef
```

Used by:

```bash
fkit firebase
```

---

# Firebase Options

## `firebase.options`

FlutterFire-generated Firebase options files.

Example:

```yaml
options:
  android: lib/firebase_options_development.dart
  ios: lib/firebase_options_development.dart
  web: lib/firebase_options_development.dart
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
  default_template: riverpod_clean
```

Planned templates:

* riverpod_clean
* bloc_clean
* mvvm
* provider_clean

---

# Flavored Project Example

```yaml
flavoring:
  enabled: true

flavors:
  default: production

  development:
    env: env/development.json

  staging:
    env: env/staging.json

  production:
    env: env/production.json
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

flavors:
  default: main

  main:
    env: env/env.json
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
