import '../core/generator_context.dart';

/// Defines the contract for maintaining generated project files.
///
/// Implementations synchronize project files after code generation using the
/// provided generator context.
abstract interface class Maintainer {
  /// Creates a maintainer.
  const Maintainer();

  /// Maintains generated project files using the provided [context].
  Future<void> maintain(GeneratorContext context);
}
