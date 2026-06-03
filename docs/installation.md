# FKIT Installation Guide

This document explains how to install and configure Flutter DevOps Kit (`fkit`) globally on your system.

---

# Requirements

Before installing FKIT, ensure the following tools are installed:

| Tool        | Required |
| ----------- | -------- |
| Dart SDK    | ✅        |
| Flutter SDK | ✅        |
| Git         | ✅        |

Optional but recommended:

| Tool         | Purpose                    |
| ------------ | -------------------------- |
| FVM          | Flutter version management |
| Firebase CLI | Firebase distribution      |
| CocoaPods    | iOS builds                 |
| Java         | Android builds             |

---

# Verify Dart Installation

Run:

```bash
dart --version
```

Example output:

```bash
Dart SDK version: 3.x.x
```

---

# Verify Flutter Installation

Run:

```bash
flutter --version
```

---

# Install FKIT Globally

Install from pub.dev:

```bash
dart pub global activate flutter_devops_kit
```

---

# Verify Installation

Run:

```bash
fkit help
```

If installed correctly, FKIT commands will appear.

---

# PATH Configuration

If `fkit` command is not recognized, add Dart global binaries to your system PATH.

---

# macOS / Linux (ZSH)

Add to:

```bash
~/.zshrc
```

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Then reload terminal:

```bash
source ~/.zshrc
```

---

# macOS / Linux (Bash)

Add to:

```bash
~/.bashrc
```

OR:

```bash
~/.bash_profile
```

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Reload shell:

```bash
source ~/.bashrc
```

---

# Windows

Add this directory to Environment Variables:

```text
C:\Users\<YOUR_USERNAME>\AppData\Local\Pub\Cache\bin
```

Then restart terminal.

---

# Update FKIT

Upgrade to latest version:

```bash
dart pub global activate flutter_devops_kit
```

---

# Remove FKIT

Uninstall globally:

```bash
dart pub global deactivate flutter_devops_kit
```

---

# Verify Environment

Run:

```bash
fkit doctor
```

Checks:

* Flutter
* Dart
* Firebase CLI
* CocoaPods
* Java
* Git

---

# First-Time Project Setup

Inside your Flutter project:

```bash
fkit init
```

This generates:

```bash
fkit.yaml
```

---

# Example Workflow

## Initialize

```bash
fkit init
```

---

## Validate Environment

```bash
fkit doctor
```

---

## Fetch Dependencies

```bash
fkit get
```

---

## Generate Files

```bash
fkit generate
```

---

## Build APK

```bash
fkit build apk production
```

---

# FVM Support

Enable FVM inside:

```yaml
tooling:
  use_fvm: true
```

FKIT automatically switches to:

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

# Firebase CLI Setup

Required for:

```bash
fkit firebase
```

---

## Install Firebase CLI

```bash
npm install -g firebase-tools
```

---

## Login

```bash
firebase login
```

---

# Common Issues

---

# `fkit: command not found`

Cause:

* PATH not configured

Solution:

Add:

```bash
$HOME/.pub-cache/bin
```

to PATH.

---

# Firebase Commands Failing

Cause:

* Firebase CLI missing
* not logged in

Solution:

```bash
firebase login
```

---

# FVM Not Working

Cause:

* FVM not installed
* `use_fvm` disabled

Solution:

Install FVM:

```bash
dart pub global activate fvm
```

Then enable:

```yaml
tooling:
  use_fvm: true
```

---

# Web Builds Failing With Flavors

Flutter Web does not fully support native Flutter flavors.

FKIT automatically skips:

```bash
--flavor
```

for web builds when flavoring is disabled.

---

# Recommended Setup

## Recommended Tooling

| Tool         | Recommendation   |
| ------------ | ---------------- |
| FVM          | Recommended      |
| Firebase CLI | Recommended      |
| CocoaPods    | Required for iOS |
| Java 17+     | Recommended      |

---

# Recommended Project Structure

```text
my_flutter_project/
├── android/
├── ios/
├── lib/
├── env/
├── pubspec.yaml
└── fkit.yaml
```

---

# Installation Verification Checklist

| Step                     | Status |
| ------------------------ | ------ |
| Dart installed           | ✅      |
| Flutter installed        | ✅      |
| FKIT activated globally  | ✅      |
| PATH configured          | ✅      |
| `fkit help` working      | ✅      |
| `fkit doctor` successful | ✅      |

---

# Related Documentation

* `configuration.md`
* `commands.md`
* `firebase.md`
* `signing.md`
