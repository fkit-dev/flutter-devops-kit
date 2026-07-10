# Changelog 

All notable changes to this project will be documented in this file. 

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