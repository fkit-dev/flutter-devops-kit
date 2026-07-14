import 'firebase_details.dart';

/// Defines Firebase configuration for an FKIT project.++++++++++++++++++++++++++++++++++++
class FirebaseConfig {
  /// Whether Firebase integration is enabled.
  final bool enabled;

  /// Default Firebase App Distribution tester group.
  final String testerGroup;

  /// Firebase configurations keyed by target name.
  ///
  /// Targets correspond to flavor names when flavoring is enabled,
  /// or `main` for projects without flavors.
  final Map<String, FirebaseDetails> configurations;

  /// Creates an FKIT Firebase configuration.
  const FirebaseConfig({
    required this.enabled,
    required this.testerGroup,
    required this.configurations,
  });

  /// Creates Firebase configuration from the provided [map].
  factory FirebaseConfig.fromMap(
    Map<dynamic, dynamic> map,
  ) {
    final configurationsMap = Map<dynamic, dynamic>.from(
      map['configurations'] ?? const {},
    );

    return FirebaseConfig(
      enabled: map['enabled'] ?? false,
      testerGroup: map['tester_group']?.toString() ?? 'internal-testers',
      configurations: configurationsMap.map(
        (key, value) => MapEntry(
          key.toString(),
          FirebaseDetails.fromMap(
            Map<String, dynamic>.from(value),
          ),
        ),
      ),
    );
  }

  /// Returns Firebase configuration for the specified [target].
  FirebaseDetails? configurationFor(String target) {
    return configurations[target];
  }
}
