/// Represents the result of an application build.
class BuildResult {
  /// The path to the generated build artifact.
  final String artifactPath;

  /// Creates a build result with the specified [artifactPath].
  BuildResult({
    required this.artifactPath,
  });
}
