# FKIT Command Guide

This guide lists the supported `fkit` commands, required context, examples, and
fallback behavior for incorrect invocations.

## Command Format

```bash
fkit <command> [arguments] [options]
```

Use command-specific help:

```bash
fkit help
fkit help feat
fkit help build
```

## Global Fallbacks

- Running `fkit` with no arguments shows general help.
- Unknown top-level commands show general help and suggest close matches.
- Commands that require a Flutter project must be run beside `pubspec.yaml`.
- Commands that require FKIT configuration must be run beside `fkit.yaml`.
- Invalid parser options print the parser error and command usage.

Examples:

```bash
fkit hepl
fkit help instal
fkit setup
```

If `fkit.yaml` is missing for a configuration-aware command, run:

```bash
fkit init
```

## Project Commands

### `fkit help [command]`

Shows all commands or details for one command.

```bash
fkit help
fkit help make
```

Fallback: unknown command names show a suggestion when available.

### `fkit doctor`

Checks local tooling such as Flutter, Dart, Git, Firebase CLI, Java, CocoaPods,
and platform tooling.

```bash
fkit doctor
```

### `fkit init`

Runs the interactive FKIT configuration wizard and writes `fkit.yaml`.

```bash
fkit init
```

Requires a Flutter project.

### `fkit setup [--yes|--force]`

Applies the selected template setup from `fkit.yaml`.

```bash
fkit setup
fkit setup --yes
```

For `bloc_clean`, setup can install theme/router/network modules, add declared
dependencies, generate bootstrap files, prepare localization, generate initial
features, synchronize routes/DI/barrels, and run post-generation commands.

Use `--yes` or `--force` to overwrite generated files without prompts and use
default module option values.

Requires a Flutter project and `fkit.yaml`.

### `fkit config [section]`

Prints the loaded FKIT configuration.

```bash
fkit config
fkit config project
fkit config environment
```

Fallback: unknown sections print an error.

### `fkit validate`

Validates FKIT configuration, entry files, environment files, Firebase option
files, and flavor settings.

```bash
fkit validate
```

## Dependency and Maintenance Commands

### `fkit get`

Runs dependency resolution.

```bash
fkit get
```

Equivalent Flutter command:

```bash
flutter pub get
```

### `fkit generate`

Runs build runner once.

```bash
fkit generate
```

Equivalent Flutter pub command:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### `fkit watch`

Runs build runner in watch mode.

```bash
fkit watch
```

### `fkit analyze`

Runs Dart analysis for `lib`.

```bash
fkit analyze
```

### `fkit format`

Formats Dart files in `lib`.

```bash
fkit format
```

### `fkit fix`

Applies Dart fixes.

```bash
fkit fix
```

## Code Generation Commands

### `fkit feat <feature> [--yes|--force] [--no-build-runner]`

Generates a complete feature using the selected template.

```bash
fkit feat auth
fkit feat profile --no-build-runner
fkit feat checkout --yes
```

Use `--yes` or `--force` to overwrite an existing generated feature. Use
`--no-build-runner` when you want to run `fkit generate` later.

Generated files require the selected template's declared dependencies.

### `fkit make <component> <feature> [name] [--yes|--force] [--no-build-runner]`

Generates one feature component or a component group.

```bash
fkit make screen auth Login
fkit make dto auth LoginRequest
fkit make resource auth User --no-build-runner
fkit make bloc auth --force
```

Supported `bloc_clean` components:

- `entity`
- `dto`
- `mapper`
- `usecase`
- `bloc`
- `state`
- `event`
- `repository`
- `repository_impl`
- `remote_datasource`
- `remote_datasource_impl`
- `local_datasource`
- `local_datasource_impl`
- `screen`

Supported `bloc_clean` groups:

- `resource`
- `bloc`
- `datasource`

Fallback: unknown components print supported components and groups.

### `fkit install <module> [--yes|--force]`

Installs a template module.

```bash
fkit install theme
fkit install router --yes
fkit install network --force
```

Available `bloc_clean` modules:

- `theme`
- `router`
- `network`

Fallback: unknown modules print available modules.

## Localization Commands

### `fkit l10n <setup|generate|doctor> [--yes|--force]`

Manages Flutter localization files and validation.

```bash
fkit l10n setup
fkit l10n generate --yes
fkit l10n doctor
```

Actions:

- `setup`: generate localization config/files and wire the app
- `generate`: regenerate localization config/files and wire the app
- `doctor`: validate localization config

Fallback: missing or unknown actions print supported actions.

## Run and Build Commands

### `fkit run [flavor] [-p] [-r] [-t android|ios|web]`

Runs the app using FKIT flavor/platform settings.

```bash
fkit run
fkit run development
fkit run staging -p
fkit run production -r
fkit run -t web
```

Options:

- `-p`, `--profile`: profile mode
- `-r`, `--release`: release mode
- `-t`, `--platform`: `android`, `ios`, or `web`

Web runs skip Flutter flavor arguments automatically.

### `fkit build <apk|aab|ipa|web> [flavor]`

Builds the app.

```bash
fkit build apk development
fkit build aab production
fkit build ipa production
fkit build web
fkit build web production
```

If `[flavor]` is omitted, FKIT uses `flavoring.default` from `fkit.yaml`.

## Firebase Commands

### `fkit firebase [target] [-p android|ios] [-n "notes"] [-g group]`

Builds and uploads to Firebase App Distribution.

```bash
fkit firebase
fkit firebase staging
fkit firebase production -p ios
fkit firebase staging -g qa -n "QA regression build"
```

Requires `firebase.enabled: true` and matching Firebase app configuration for
the target/platform.

Fallbacks:

- disabled Firebase prints a clear error
- unknown targets print a clear error
- disabled platforms print a clear error
- missing Firebase platform config prints a clear error

## Signing Commands

### `fkit signing <setup|doctor>`

Manages Android signing configuration.

```bash
fkit signing setup
fkit signing doctor
```

Fallback: missing or unknown actions print supported actions.

## Launcher Icon Commands

### `fkit icon <generate|configure|doctor>`

Manages `flutter_launcher_icons` configuration and generation.

```bash
fkit icon configure
fkit icon generate
fkit icon doctor
```

Fallback: missing or unknown actions print supported actions.

## Extension Commands

### `fkit extension generate`

Generates common Flutter extension files.

```bash
fkit extension generate
```

Fallback: missing or unknown actions print supported actions.

## Flavor Behavior

Flavored projects:

```yaml
flavoring:
  enabled: true
  default: development

flavors:
  - development
  - staging
  - production
```

FKIT passes Flutter flavor arguments for mobile builds and runs.

Non-flavored projects:

```yaml
flavoring:
  enabled: false
  default: main

flavors:
  - main
```

FKIT skips Flutter flavor arguments.

## FVM Support

Enable FVM in `fkit.yaml`:

```yaml
tooling:
  use_fvm: true
```

FKIT then runs commands through `fvm flutter` and `fvm dart`.

## Common Workflows

Fresh setup:

```bash
flutter create my_app
cd my_app
fkit init
fkit setup --yes
```

Feature generation:

```bash
fkit feat auth --no-build-runner
fkit make dto auth LoginRequest --no-build-runner
fkit generate
```

Localization:

```bash
fkit l10n setup --yes
fkit l10n doctor
```

Production Android build:

```bash
fkit validate
fkit build apk production
```

Firebase QA distribution:

```bash
fkit firebase staging -p android -g qa -n "QA build"
```

## Planned Commands

These commands are planned and not implemented in the current release:

```bash
fkit release
fkit deploy
fkit changelog
fkit version
fkit ci
fkit store
```
