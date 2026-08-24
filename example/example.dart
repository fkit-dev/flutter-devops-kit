/// Flutter DevOps Kit example workflow for pub.dev.
///
/// FKIT is primarily used as a command-line application.
///
/// Install globally:
///
/// ```bash
/// dart pub global activate flutter_devops_kit
/// ```
///
/// Initialize FKIT inside a Flutter project:
///
/// ```bash
/// fkit init
/// ```
///
/// Review `fkit.yaml`, then set up the project using the selected architecture
/// template:
///
/// ```bash
/// fkit setup --yes
/// ```
///
/// Generate a feature without running build runner immediately:
///
/// ```bash
/// fkit feat auth --no-build-runner
/// fkit generate
/// ```
///
/// Install a reusable module:
///
/// ```bash
/// fkit install network --yes
/// ```
///
/// Ask for command-specific help when needed:
///
/// ```bash
/// fkit help make
/// fkit help build
/// ```
void main() {}
