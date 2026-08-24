# Flutter DevOps Kit (FKIT)

[![Pub Version](https://img.shields.io/pub/v/flutter_devops_kit.svg)](https://pub.dev/packages/flutter_devops_kit)
[![Pub Likes](https://img.shields.io/pub/likes/flutter_devops_kit)](https://pub.dev/packages/flutter_devops_kit)
[![Pub Points](https://img.shields.io/pub/points/flutter_devops_kit)](https://pub.dev/packages/flutter_devops_kit)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

FKIT is a command-line toolkit for Flutter project setup, feature scaffolding,
module installation, localization, flavors, builds, signing, Firebase App
Distribution, and day-to-day maintenance.

The current production-ready architecture template is `bloc_clean`. Riverpod,
MVVM, Provider, and GetX templates are planned.

## Installation

Install FKIT globally:

```bash
dart pub global activate flutter_devops_kit
```

Make sure Dart global executables are on your `PATH`.

macOS/Linux:

```bash
export PATH="$PATH:$HOME/.pub-cache/bin"
```

Windows:

```text
%LOCALAPPDATA%\Pub\Cache\bin
```

Verify:

```bash
fkit help
fkit doctor
```

Update:

```bash
dart pub global activate flutter_devops_kit
```

Uninstall:

```bash
dart pub global deactivate flutter_devops_kit
```

## Requirements

- Flutter SDK
- Dart SDK
- Git
- Firebase CLI, only for Firebase App Distribution workflows
- Java/Android tooling, only for Android builds/signing
- Xcode/CocoaPods, only for iOS builds

Run `fkit doctor` to check the local environment.

## Quick Start

Run these commands inside a Flutter project root:

```bash
fkit init
fkit setup --yes
fkit feat profile --no-build-runner
fkit make screen profile Profile --no-build-runner
fkit generate
fkit run development
```

`fkit init` creates `fkit.yaml`. `fkit setup` applies the selected template,
adds declared dependencies, installs setup modules, generates bootstrap files,
generates localization files when enabled, and runs required generation steps.

## Configuration

Minimal `fkit.yaml`:

```yaml
fkit:
  version: 0.1.1

project_name: my_app

tooling:
  use_fvm: false

platforms:
  android: true
  ios: true
  web: false

generator:
  feature_dir: lib/features
  default_template: bloc_clean

entry:
  main: lib/main.dart

flavoring:
  enabled: false
  default: main

flavors:
  - main

environment:
  enabled: false
  configurations: {}

firebase:
  enabled: false
  tester_group: internal-testers
  configurations: {}

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

A larger documented sample is available in [example/fkit.yaml](example/fkit.yaml).
A minimal Flutter fixture for setup testing is available in
[example/flutter_app](example/flutter_app).

## Core Commands

| Command | Purpose |
| --- | --- |
| `fkit help [command]` | Show command help |
| `fkit doctor` | Check local tooling |
| `fkit init` | Create `fkit.yaml` interactively |
| `fkit setup [--yes\|--force]` | Apply the selected template setup |
| `fkit config [section]` | Print the loaded FKIT configuration |
| `fkit validate` | Validate project configuration |
| `fkit get` | Run `flutter pub get` |
| `fkit generate` | Run build runner |
| `fkit watch` | Run build runner in watch mode |
| `fkit analyze` | Run Dart analysis |
| `fkit format` | Format Dart files |
| `fkit fix` | Apply Dart fixes |
| `fkit feat <feature> [--yes\|--force] [--no-build-runner]` | Generate a feature |
| `fkit make <component> <feature> [name] [--yes\|--force] [--no-build-runner]` | Generate a component |
| `fkit install <module> [--yes\|--force]` | Install a template module |
| `fkit l10n <setup\|generate\|doctor> [--yes\|--force]` | Manage localization |
| `fkit run [flavor] [-p] [-r] [-t android\|ios\|web]` | Run the app |
| `fkit build <apk\|aab\|ipa\|web> [flavor]` | Build the app |
| `fkit firebase [target] [-p android\|ios] [-n "notes"] [-g group]` | Build and upload to Firebase App Distribution |
| `fkit signing <setup\|doctor>` | Manage Android signing |
| `fkit icon <generate\|configure\|doctor>` | Manage launcher icons |
| `fkit extension generate` | Generate common Flutter extensions |

For detailed usage and examples, see [doc/commands.md](doc/commands.md).

## Generation Flags

- `--yes` and `--force` overwrite generated files without interactive prompts.
- `--no-build-runner` skips build runner for feature and component generation.
- Setup and localization services can be tested without external Flutter
  commands through their service-level APIs.

Generated feature files require the selected template's declared dependencies.
For `bloc_clean`, setup adds the required BLoC, Freezed, JSON serialization, and
build runner packages.

## Available Template and Modules

Template:

- `bloc_clean`: feature-first Clean Architecture using `flutter_bloc`

Setup modules:

- `theme`: Material 3 theme, theme cubit, colors, typography
- `router`: GoRouter configuration and route markers
- `network`: Dio API service, response models, failures, interceptors, optional Talker logging

## Fallbacks and Error Handling

FKIT provides explicit fallbacks for common incorrect invocations:

- Unknown top-level commands print help and suggest close command names.
- `fkit help <unknown>` suggests close command names.
- Commands that require a Flutter project fail early when `pubspec.yaml` is
  missing or does not look like a Flutter project.
- Commands that require FKIT configuration fail early when `fkit.yaml` is
  missing and tell you to run `fkit init`.
- Subcommands such as `fkit l10n`, `fkit signing`, `fkit icon`, and
  `fkit extension` print supported actions when an action is missing or invalid.

Examples:

```bash
fkit hepl
fkit help install
fkit l10n unknown
```

## Common Workflows

Fresh BLoC project setup:

```bash
flutter create my_app
cd my_app
fkit init
fkit setup --yes
```

Generate a feature without running build runner immediately:

```bash
fkit feat auth --no-build-runner
fkit generate
```

Install modules manually:

```bash
fkit install theme --yes
fkit install router --yes
fkit install network --yes
```

Localization:

```bash
fkit l10n setup --yes
fkit l10n doctor
```

Flavor-aware build:

```bash
fkit build apk production
fkit build web production
```

Firebase distribution:

```bash
fkit firebase staging -p android -g qa -n "QA regression build"
```

## Documentation

- [Command guide](doc/commands.md)
- [Configuration guide](doc/configuration.md)
- [Feature scaffolding](doc/feature-scaffolding.md)
- [Signing guide](doc/signing.md)
- [Firebase guide](doc/firebase.md)
- [Roadmap](doc/roadmap.md)

## Status

FKIT is under active development. The `bloc_clean` template is the supported
production-ready template in this release; other architecture templates are
planned and intentionally unavailable until their manifests are implemented.

## License

MIT. See [LICENSE](LICENSE).
