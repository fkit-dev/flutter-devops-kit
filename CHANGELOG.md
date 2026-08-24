# Changelog 

All notable changes to this project will be documented in this file. 

## 0.1.4

### Added

- Added a checked-in minimal Flutter fixture under `example/flutter_app` for
  setup, localization, module, feature, and component generation validation.
- Added fixture-backed service tests for BLoC setup generation, localization
  wiring, dependency collection, duplicate-safe maintenance, and component
  overwrite behavior.
- Added command suggestion support for mistyped top-level commands and
  `fkit help <command>`.
- Added centralized CLI preflight checks for commands that require a Flutter
  project or `fkit.yaml`.
- Added `.pubignore` entries to keep local artifacts and experimental templates
  out of pub package archives.

### Changed

- Reworked `README.md` for pub.dev with installation, PATH setup,
  requirements, quick start, configuration, command reference, workflows, and
  fallback guidance.
- Rewrote `doc/commands.md` as the complete guidebook for supported commands,
  arguments, flags, examples, and invalid-command behavior.
- Updated `example/example.dart` and `example/fkit.yaml` to show safer,
  copyable package usage with Firebase disabled by default.
- Updated `doc/configuration.md` to use the current sectioned `fkit.yaml`
  structure.
- Marked `bloc_clean` as the current production-ready template and Riverpod,
  MVVM, Provider, and GetX templates as planned.
- Improved non-interactive generation semantics for setup, module installation,
  bootstrap generation, localization setup, feature generation, and component
  generation.
- Improved BLoC template setup dependencies to include required BLoC, Freezed,
  JSON serialization, and build runner packages.

### Fixed

- Fixed localization setup to wire the selected template's configured App file
  instead of hardcoding `lib/app/app.dart`.
- Fixed localization import generation to use a relative import path from the
  generated App file.
- Fixed setup ordering so localization files are generated before bootstrap App
  maintenance and App localization wiring happens after bootstrap generation.
- Fixed template and module validation to fail early when referenced manifests
  or template files are missing.
- Fixed stale template/module documentation that advertised unavailable planned
  modules or templates as current.
- Fixed package version reporting by updating `FkitVersion.current` to `0.1.4`.

## 0.1.3

### Added

- Added `fkit setup` command for automated project bootstrap.
- Added interactive project bootstrapping with generated `main.dart` and `app.dart`.
- Added configurable template bootstrap support.
- Added project setup workflow for installing modules and generating default features.
- Added configuration update commands:
  - `fkit config flavors`
  - `fkit config environment`
  - `fkit config firebase`
  - `fkit config localization`
- Added configuration reconciliation to preserve dependent configuration when flavor targets change.
- Added centralized configuration mapping utilities.
- Added support for standalone Environment configuration.
- Added support for standalone Firebase configuration.
- Added support for standalone Localization configuration.
- Added configurable template setup and bootstrap definitions.

### Changed

- Refactored FKIT configuration model to separate:
  - Flavor configuration
  - Environment configuration
  - Firebase configuration
  - Localization configuration
- Refactored `fkit.yaml` to use dedicated configuration sections.
- Refactored project initialization wizard to use the new configuration model.
- Refactored module installation workflow to support deferred dependency synchronization and post-generation tasks.
- Refactored project setup into reusable services.
- Refactored router integration into the generic module integration system.
- Improved template architecture with configurable setup and bootstrap support.
- Improved configuration display and update workflow.
- Improved project validation for Environment, Firebase, Localization, and Flavor configurations.
- Improved localization generation workflow.
- Improved Firebase configuration to support projects with and without flavors.

### Fixed

- Fixed router integration during module installation.
- Fixed dependency synchronization during multi-module project setup.
- Fixed build runner execution to run only once during project setup.
- Fixed Firebase configuration handling for non-flavored projects.
- Fixed environment configuration handling for non-flavored projects.
- Fixed configuration updates when adding or removing flavor targets.

## 0.1.2

### Added

- Added Dart documentation comments for public APIs. 
- Added automated tests covering: 
- Command registry behavior. 
- Constructor dependency resolution. 
- Naming service functionality. 
- Template rendering and output generation. 
- Added `example/example.dart` demonstrating the standard FKIT CLI workflow. 

### Changed

- Expanded README documentation with package installation and setup instructions.
- Improved public API documentation and overall documentation coverage.

## 0.1.1

### Added

- Template-driven project generation architecture.
- BLoC Clean Architecture template support.
- Project setup automation with `fkit setup`.
- Template-defined setup workflows for modules, features, and application bootstrap.
- Automatic `main.dart` and `app.dart` bootstrap generation.
- Interactive overwrite handling for existing bootstrap files.
- Reusable module installation system with `fkit install`.
- Module-specific configuration options and interactive prompts.
- Conditional module files and package dependencies.
- Template-level dependency requirements.
- Module integration system with generic and DI-specific integrators.
- Router module integration and automatic route synchronization.
- Network module with:
    - Dio-based API service.
    - Typed API responses.
    - Response mappers.
    - Pagination models.
    - API response extensions.
    - Centralized failure handling.
    - Network connectivity monitoring.
    - Network interceptor.
    - Authentication interceptor.
    - Optional Talker logging.
- Theme module generation.
- Router module generation.
- GoRouter route discovery and synchronization.
- Existing route detection to prevent duplicate route generation.
- Feature generation service for reusable programmatic feature generation.
- Component and resource generation workflows.
- Localization setup, generation, and validation commands.
- Flutter extension generation.
- Template setup configuration.
- Template bootstrap configuration.
- Windows global CLI installation instructions.

### Changed

- Refactored module installation logic into `ModuleInstallationService`.
- Refactored module integration into dedicated integrators and registry.
- Improved dependency synchronization during project setup.
- Reduced redundant `pub get` and code generation executions during setup.
- Improved module package handling with conditional dependencies.
- Improved project configuration model with FKIT version support.
- Improved generated route formatting and synchronization.
- Improved generated network response and failure handling.
- Updated FKIT project configuration examples.
- Expanded README documentation and feature overview.
- Improved generator and setup architecture for future template support.

### Fixed

- Fixed route generation producing invalid enum syntax.
- Fixed duplicate and missing route detection.
- Fixed module options causing boolean-to-string type errors.
- Fixed conditional package resolution during module installation.
- Fixed generated response mapper constant generic type error.
- Fixed missing dependencies during full project setup.
- Fixed Dio exception handling for newer `DioExceptionType` values.
- Fixed build runner execution ordering during project setup.

## 0.1.0

### Added

- Flutter build automation.
- APK, AAB, IPA, and Web build support.
- Firebase App Distribution integration.
- Android signing setup automation.
- Feature scaffolding.
- Environment validation.
- Interactive FKIT initialization.
- Riverpod Clean Architecture templates.
- Web flavor handling improvements.
- Enhanced logging system.
- Configuration validation.
