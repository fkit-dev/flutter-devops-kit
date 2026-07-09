# Changelog

All notable changes to this project will be documented in this file.

## 0.1.1

### Added

- Cross-platform installation documentation for macOS, Linux, and Windows
- Configurable feature directory support through `generator.feature_dir`
- Template-driven module installation system
- Interactive module configuration options
- Conditional module file generation
- Conditional package and development dependency installation
- Module integration infrastructure
- Dependency-injection-aware module integrator registry
- Theme module for reusable Material 3 theme setup
- Router module with GoRouter integration
- Automatic route discovery based on template configuration
- Automatic route synchronization when generating screens
- Existing route detection to prevent duplicate route generation
- Marker-based route and import maintenance to preserve developer customizations
- Network module with Dio-based API infrastructure
- Typed API response models and response mappers
- Generic API response parsing
- Freezed and JSON serialization support for network models
- Centralized API failure and exception handling
- Dio error-to-application-exception mapping
- Network connectivity monitoring and request interception
- Optional Talker application and API logging
- Conditional Talker dependencies and generated logging files
- Network module integration infrastructure for dependency injection
- FKIT configuration version metadata

### Changed

- Improved `fkit init` configuration generation
- Updated `InitConfig` to support FKIT version metadata and configurable feature directories
- Simplified localization configuration by deriving the template ARB file from the default locale
- Improved YAML generation with dedicated configuration sections
- Improved module package and development dependency resolution
- Improved module generation cancellation and overwrite handling
- Improved router generation to append missing routes instead of rewriting developer changes
- Improved template architecture to support reusable and extensible modules
- Updated README with current, ongoing, and planned FKIT features
- Updated package description and metadata for the `0.1.1` release

### Fixed

- Fixed launcher icon generation issues when updating YAML configuration
- Fixed Flutter package command execution for Flutter projects
- Fixed uninitialized `PubspecService` editor errors
- Fixed module option type handling for boolean configuration values
- Fixed conditional dependency resolution for module packages
- Fixed router synchronization not running after router module installation
- Fixed generated route enum syntax when appending new routes
- Fixed incorrect route import path generation
- Fixed duplicate route generation during synchronization
- Fixed generic `const` creation error in generated response mappers
- Fixed missing dependency installation during network module generation

## 0.1.0

### Added

- Flutter build automation
- APK, AAB, IPA, and Web build support
- Firebase App Distribution integration
- Android signing setup automation
- Feature scaffolding
- Environment validation
- Interactive FKIT initialization
- Riverpod clean architecture templates
- Web flavor handling improvements
- Enhanced logging system
- Config validation