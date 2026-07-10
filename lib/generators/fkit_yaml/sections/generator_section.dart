import '../../../models/init_config.dart';

/// Defines a section that writes generated configuration content.
abstract class GeneratorSection {
  /// Writes this section's content to [buffer] using the provided [config].
  void write(
    StringBuffer buffer,
    InitConfig config,
  );
}
