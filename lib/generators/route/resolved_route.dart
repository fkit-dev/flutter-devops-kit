class ResolvedRoute {
  const ResolvedRoute({
    required this.name,
    required this.path,
    required this.className,
    required this.file,
  });

  /// Route identifier.
  ///
  /// Example:
  /// editProfile
  final String name;

  /// Route path.
  ///
  /// Example:
  /// /edit-profile
  final String path;

  /// Screen class.
  ///
  /// Example:
  /// EditProfileScreen
  final String className;

  /// Absolute screen file path.
  ///
  /// Used later by the maintainer to resolve imports.
  final String file;
}
