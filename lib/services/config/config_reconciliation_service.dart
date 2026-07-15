import '../../models/config/config_reconciliation_result.dart';
import '../../models/environment/environment_config.dart';
import '../../models/environment/environment_details.dart';
import '../../models/firebase/firebase_config.dart';
import '../../models/firebase/firebase_details.dart';
import '../../models/init_config.dart';
import '../../wizard/models/flavor_setup.dart';

/// Reconciles dependent configuration after flavor targets change.
///
/// Removes obsolete Environment and Firebase configurations for deleted
/// targets while preserving existing configuration for unchanged targets.
///
/// Newly added targets are reported so that callers can collect the
/// missing configuration interactively.
class ConfigReconciliationService {
  /// Creates a configuration reconciliation service.
  const ConfigReconciliationService();

  /// Reconciles the current project configuration against the updated
  /// flavor configuration.
  ///
  /// Returns the cleaned Environment and Firebase configuration together
  /// with the detected added and removed targets.
  ConfigReconciliationResult reconcile(
      {required InitConfig current, required FlavorSetup updated}) {
    final currentTargets = current.flavors.toSet();
    final newTargets = updated.flavors.toSet();

    final added = newTargets.difference(currentTargets).toList()..sort();

    final removed = currentTargets.difference(newTargets).toList()..sort();

    final environment = _reconcileEnvironment(
      current.environment,
      removed,
    );

    final firebase = _reconcileFirebase(
      current.firebase,
      removed,
    );

    return ConfigReconciliationResult(
      environment: environment,
      firebase: firebase,
      addedTargets: added,
      removedTargets: removed,
    );
  }

  EnvironmentConfig _reconcileEnvironment(
    EnvironmentConfig current,
    List<String> removed,
  ) {
    final configs = Map<String, EnvironmentDetails>.from(
      current.configurations,
    );

    for (final target in removed) {
      configs.remove(target);
    }

    return EnvironmentConfig(
      enabled: current.enabled,
      configurations: configs,
    );
  }

  FirebaseConfig _reconcileFirebase(
    FirebaseConfig current,
    List<String> removed,
  ) {
    final configs = Map<String, FirebaseDetails>.from(
      current.configurations,
    );

    for (final target in removed) {
      configs.remove(target);
    }

    return FirebaseConfig(
      enabled: current.enabled,
      testerGroup: current.testerGroup,
      configurations: configs,
    );
  }
}
