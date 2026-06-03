# FKIT Roadmap

This document outlines the planned future direction of Flutter DevOps Kit (`fkit`).

---

# Vision

FKIT aims to become:

```text id="jlwm0bj"
The scalable engineering toolkit for Flutter teams.
```

The long-term goal is to standardize:

* Flutter project automation
* release workflows
* CI/CD integration
* architecture generation
* deployment tooling
* engineering workflows

across Flutter projects.

---

# Current Capabilities

## Available Today

* Flutter build automation
* APK / AAB / IPA / Web builds
* Firebase App Distribution
* Android signing setup
* Environment validation
* Interactive initialization
* Feature scaffolding
* Riverpod clean architecture generation
* Flavor-aware workflows
* FVM support
* Enhanced logging system
* Config validation

---

# Roadmap Stages

---

# Phase 1 — Foundation

## Status: In Progress

Core CLI infrastructure and reusable automation.

### Goals

* stable configuration architecture
* reusable command system
* scalable project support
* multi-platform workflows

### Features

* YAML configuration
* build automation
* Firebase distribution
* Android signing
* feature generation
* logging system
* validation layer

---

# Phase 2 — Generator Expansion

## Status: Planned

Expand architecture generation support.

### Planned Templates

| Template       | Status  |
| -------------- | ------- |
| riverpod_clean | ✅       |
| bloc_clean     | Planned |
| mvvm           | Planned |
| provider_clean | Planned |
| getx_clean     | Planned |

---

## Planned Generators

* route generation
* localization generation
* API scaffolding
* repository generators
* DTO generators
* test generation
* design system integration

---

# Phase 3 — Deployment Automation

## Status: Planned

Automate release and deployment workflows.

### Planned Commands

```bash id="’winiiii361"
fkit deploy
fkit release
fkit changelog
fkit version
```

---

## Planned Integrations

* Firebase Hosting
* Vercel deployment
* Netlify deployment
* Play Store deployment
* App Store deployment

---

# Phase 4 — CI/CD Automation

## Status: Planned

Generate reusable CI/CD pipelines.

### Planned Features

* GitHub Actions templates
* GitLab CI templates
* Bitbucket pipelines
* Codemagic workflows
* Fastlane integration

---

## Planned Commands

```bash id="’winiiii362"
fkit ci setup
fkit ci validate
```

---

# Phase 5 — Release Management

## Status: Planned

Release engineering workflows.

### Planned Features

* semantic versioning
* Git tagging
* automated changelog generation
* release note generation
* release channels

---

## Planned Commands

```bash id="’winiiii363"
fkit release patch
fkit release minor
fkit release major
```

---

# Phase 6 — Team Collaboration

## Status: Planned

Improve developer collaboration workflows.

### Planned Features

* team templates
* workspace presets
* shared configs
* environment sharing
* engineering conventions

---

# Phase 7 — Advanced DevOps

## Status: Planned

Enterprise-grade Flutter DevOps workflows.

### Planned Features

* build caching
* artifact management
* deployment history
* rollback support
* release analytics
* monitoring integration

---

# Web Deployment Roadmap

## Planned Support

* Vercel deployment
* Firebase Hosting
* Cloudflare Pages
* Netlify
* GitHub Pages

---

## Example Future Workflow

```bash id="’winiiii364"
fkit build web
fkit deploy web vercel
```

---

# Android Roadmap

## Planned Improvements

* automatic Gradle signing injection
* Play Store publishing
* signing key rotation
* ProGuard management
* Play Integrity integration

---

# iOS Roadmap

## Planned Improvements

* IPA automation
* TestFlight distribution
* App Store Connect integration
* provisioning profile automation
* certificate management

---

# Firebase Roadmap

## Planned Improvements

* tester group automation
* Crashlytics symbol upload
* Firebase Hosting
* release channels
* analytics integration

---

# Architecture Roadmap

## Planned Improvements

* monorepo support
* modular Flutter support
* plugin template generation
* package generation
* shared module generation

---

# Developer Experience Goals

FKIT aims to provide:

* modern CLI UX
* interactive workflows
* beautiful logging
* reusable automation
* minimal configuration
* scalable team workflows

---

# Long-Term Vision

The long-term goal is to make FKIT:

```text id="’winiiii365"
A complete DevOps ecosystem for Flutter engineering.
```

similar to what tools like:

* Nx
* Turborepo
* Fastlane
* Melos
* Mason

provide for other ecosystems.

---

# Future Architecture Direction

Planned internal improvements:

* CommandRunner migration
* plugin system
* command auto-discovery
* extensible generators
* modular services

---

# Community Contributions

Contributions are welcome in areas like:

* CI/CD automation
* deployment providers
* architecture generators
* documentation
* testing
* UX improvements

---

# Suggested Future Milestones

| Version | Goal                  |
| ------- | --------------------- |
| 0.1.x   | Core stabilization    |
| 0.2.x   | Generator expansion   |
| 0.3.x   | Deployment automation |
| 0.5.x   | CI/CD support         |
| 1.0.0   | Stable public release |

---

# Current Focus

The current FKIT priority is:

```text id="’winiiii366"
Stabilize reusable multi-project automation workflows.
```

before expanding into enterprise CI/CD tooling.

---

# Related Documentation

* `configuration.md`
* `commands.md`
* `feature-scaffolding.md`
* `firebase.md`
* `signing.md`
