# Feature Scaffolding Guide

This document explains how to generate feature modules using Flutter DevOps Kit (`fkit`).

---

# Overview

FKIT supports automated feature scaffolding for Flutter projects.

Feature scaffolding helps standardize:

* folder structure
* architecture
* state management
* naming conventions
* scalable project organization

---

# Generate Feature

Basic command:

```bash id="jlwm0bi"
fkit feat auth
```

This generates a feature module named:

```text id="’winiiii342"
auth
```

---

# Generated Structure

Example:

```text id="’winiiii343"
lib/features/auth/
```

---

# Current Supported Architecture

## Riverpod Clean Architecture

Current default template:

```yaml id="’winiiii344"
generator:
  default_template: bloc_clean
```

---

# Example Generated Structure

```text id="’winiiii345"
lib/features/auth/
├── data/
│   ├── datasource/
│   ├── dto/
│   ├── repository/
│   └── mapper/
│
├── domain/
│   ├── entity/
│   ├── repository/
│   └── usecase/
│
├── presentation/
│   ├── view/
│   ├── widget/
│   ├── state/
│   └── viewmodel/
│
└── auth.dart
```

---

# Feature Naming

## Recommended

Use:

```bash id="’winiiii346"
snake_case
```

Examples:

```bash id="’winiiii347"
fkit feat auth
fkit feat profile
fkit feat transaction_history
```

---

## Avoid

Avoid:

```bash id="’winiiii348"
fkit feat Transaction
fkit feat AUTH
```

---

# Architecture Philosophy

FKIT follows:

* feature-first architecture
* scalable folder separation
* clean architecture principles
* reusable domain layers
* maintainable presentation layers

---

# Riverpod Structure

## ViewModel Layer

Current Riverpod template generates:

```text id="’winiiii349"
viewmodel/
```

for:

* business logic
* state updates
* API handling
* field management

---

## State Layer

```text id="’winiiii350"
state/
```

contains:

* immutable UI state
* loading states
* form states
* async state wrappers

---

# Data Layer

## datasource/

Responsible for:

* APIs
* local storage
* Firebase
* caching

---

## dto/

Contains:

* request DTOs
* response DTOs
* serialization models

---

## mapper/

Responsible for:

* DTO ↔ entity mapping
* transformation logic

---

# Domain Layer

## entity/

Pure business entities.

Should NOT contain:

* UI logic
* framework logic
* serialization logic

---

## repository/

Abstract repository contracts.

---

## usecase/

Business workflows and operations.

---

# Presentation Layer

## view/

Screen-level widgets.

Examples:

```text id="’winiiii351"
login_view.dart
profile_view.dart
```

---

## widget/

Reusable feature widgets.

Examples:

```text id="’winiiii352"
profile_card.dart
auth_header.dart
```

---

# Configure Default Template

Inside:

```bash id="’winiiii353"
fkit.yaml
```

---

## Example

```yaml id="’winiiii354"
generator:
  default_template: bloc_clean
```

---

# Template Status

Current and planned architecture generators:

| Template       | Status  |
| -------------- | ------- |
| bloc_clean     | Current, production-ready |
| riverpod_clean | Planned |
| mvvm           | Planned |
| provider_clean | Planned |
| getx_clean     | Planned |

---

# BLoC Structure

Current generated structure:

```text id="’winiiii355"
presentation/
├── bloc/
│   ├── auth_bloc.dart
│   ├── auth_event.dart
│   └── auth_state.dart
```

---

# Planned MVVM Structure

Future generated structure:

```text id="’winiiii356"
presentation/
├── view/
├── viewmodel/
└── widget/
```

---

# Recommended Workflow

## Create Feature

```bash id="’winiiii357"
fkit feat auth
```

---

## Generate Files

```bash id="’winiiii358"
fkit generate
```

---

## Start Development

Implement:

* DTOs
* repositories
* entities
* view models
* UI

---

# Best Practices

## Recommended

* Keep features isolated
* Use feature-based routing
* Avoid cross-feature dependencies
* Keep domain layer pure
* Keep presentation layer lightweight

---

## Avoid

* giant shared folders
* tightly coupled features
* business logic inside widgets
* feature leakage

---

# Recommended Project Structure

```text id="’winiiii359"
lib/
├── core/
├── shared/
├── features/
│   ├── auth/
│   ├── profile/
│   └── transaction/
```

---

# Future Scope

Planned scaffolding improvements:

* route generation
* localization generation
* API template generation
* test generation
* repository generation
* DTO generation
* Firebase integration templates
* design system integration

---

# Long-Term Goal

FKIT aims to become:

```text id="’winiiii360"
The scalable engineering toolkit for Flutter teams.
```

with reusable architecture generators and workflow automation.

---

# Related Documentation

* `configuration.md`
* `commands.md`
* `firebase.md`
* `signing.md`
