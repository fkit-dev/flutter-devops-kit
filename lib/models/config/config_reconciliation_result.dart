import '../environment/environment_config.dart';
import '../firebase/firebase_config.dart';

/// Represents the outcome of reconciling project configuration after
/// the configured flavor targets have changed.
///
/// Contains the reconciled Environment and Firebase configurations,
/// together with the detected target additions and removals.
class ConfigReconciliationResult {
  /// Creates a reconciliation result.
  const ConfigReconciliationResult({
    required this.environment,
    required this.firebase,
    required this.addedTargets,
    required this.removedTargets,
  });

  /// The reconciled environment configuration.
  final EnvironmentConfig environment;

  /// The reconciled Firebase configuration.
  final FirebaseConfig firebase;

  /// Targets that were newly added.
  final List<String> addedTargets;

  /// Targets that were removed.
  final List<String> removedTargets;

  /// Whether reconciliation resulted in any changes.
  bool get hasChanges => addedTargets.isNotEmpty || removedTargets.isNotEmpty;
}
