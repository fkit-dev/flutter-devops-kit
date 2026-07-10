/// Represents the result of an FKIT module installation.
class ModuleInstallationResult {
  /// Creates a module installation result.
  const ModuleInstallationResult({
    required this.moduleName,
    required this.installed,
    required this.requiresBuildRunner,
  });

  /// The name of the module associated with the installation.
  final String moduleName;

  /// Whether the module was installed successfully.
  final bool installed;

  /// Whether the installed module requires build runner execution.
  final bool requiresBuildRunner;
}
