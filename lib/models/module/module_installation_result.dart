class ModuleInstallationResult {
  const ModuleInstallationResult({
    required this.moduleName,
    required this.installed,
    required this.requiresBuildRunner,
  });

  final String moduleName;
  final bool installed;
  final bool requiresBuildRunner;
}
