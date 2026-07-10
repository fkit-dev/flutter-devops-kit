import 'command_category.dart';

/// Defines the contract for commands supported by FKIT.
///
/// Implementations provide command metadata, usage information, optional
/// aliases and examples, and the logic executed when the command is invoked.
abstract class Command {
  /// The name used to invoke the command.
  String get name;

  /// A short description of what the command does.
  String get description;

  /// The category used to group the command.
  CommandCategory get category;

  /// The usage syntax displayed in help output.
  String get usage;

  /// Example invocations demonstrating how to use the command.
  ///
  /// Returns an empty list by default.
  List<String> get examples => const [];

  /// Alternative names that can be used to invoke the command.
  ///
  /// Returns an empty list by default.
  List<String> get aliases => const [];

  /// Whether the command should be excluded from standard command listings.
  ///
  /// Defaults to `false`.
  bool get hidden => false;

  /// Whether the command requires an FKIT configuration file.
  ///
  /// Defaults to `false`.
  bool get requiresConfig => false;

  /// Whether the command must be executed inside a Flutter project.
  ///
  /// Defaults to `false`.
  bool get requiresFlutterProject => false;

  /// Executes the command using the provided command-line [args].
  Future<void> run(List<String> args);
}
