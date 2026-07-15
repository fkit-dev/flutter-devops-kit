import 'package:flutter_devops_kit/models/firebase/firebase_config.dart';

import '../../mappers/config_mapper.dart';
import '../../models/config/config_section.dart';
import '../../models/environment/environment_config.dart';
import '../../models/init_config.dart';
import '../../wizard/models/flavor_setup.dart';
import '../../wizard/steps/environment_step.dart';
import '../../wizard/steps/firebase_step.dart';
import '../../wizard/steps/flavor_step.dart';
import '../../wizard/steps/localization_step.dart';
import '../logger_service.dart';
import 'config_reconciliation_service.dart';
import 'config_section_writer.dart';

/// Updates individual FKIT project configuration sections.
class ConfigUpdateService {
  /// Creates a configuration update service.
  const ConfigUpdateService();

  /// Updates the specified configuration [section].
  Future<void> update({required ConfigSection section, required InitConfig config}) async {
    LoggerService.section('Update ${section.name} Configuration');

    switch (section) {
      case ConfigSection.flavors:
        await _updateFlavors(config);

      case ConfigSection.environment:
        await _updateEnvironment(config);

      case ConfigSection.firebase:
        await _updateFirebase(config);

      case ConfigSection.localization:
        await _updateLocalization(config);
    }

    LoggerService.blank();
    LoggerService.success('${section.name} configuration updated successfully.');
    LoggerService.blank();
  }

  Future<void> _updateFlavors(InitConfig config) async {
    final flavors = FlavorStep(current: config).collect();
    final reconciliation = const ConfigReconciliationService().reconcile(current: config, updated: flavors);

    var environment = reconciliation.environment;
    var firebase = reconciliation.firebase;

    if (reconciliation.addedTargets.isNotEmpty) {
      final addedFlavorSetup = FlavorSetup(
        enabled: flavors.enabled,
        defaultFlavor: flavors.defaultFlavor,
        flavors: reconciliation.addedTargets,
      );

      final addedEnvironment = EnvironmentStep(flavors: addedFlavorSetup, current: environment).collect();

      environment = EnvironmentConfig(
        enabled: addedEnvironment.enabled,
        configurations: {
          ...environment.configurations,
          ...addedEnvironment.configurations,
        },
      );

      final addedFirebase = FirebaseStep(
        platforms: ConfigMapper.toPlatformSetup(config),
        flavors: addedFlavorSetup,
        current: firebase,
      ).collect();

      firebase = FirebaseConfig(
        enabled: addedFirebase.enabled,
        testerGroup: addedFirebase.testerGroup,
        configurations: {
          ...firebase.configurations,
          ...addedFirebase.configurations,
        },
      );
    }

    await const ConfigSectionWriter().write({
      'flavoring': {
        'enabled': flavors.enabled,
        'default': flavors.defaultFlavor,
      },
      'flavors': flavors.flavors,
      'environment': {
        'enabled': environment.enabled,
        'configurations': {
          for (final entry in environment.configurations.entries) entry.key: entry.value.toMap(),
        },
      },
      'firebase': {
        'enabled': firebase.enabled,
        'tester_group': firebase.testerGroup,
        'configurations': {
          for (final entry in firebase.configurations.entries) entry.key: entry.value.toMap(),
        },
      },
    });
  }

  Future<void> _updateEnvironment(InitConfig config) async {
    final flavors = ConfigMapper.toFlavorSetup(config);

    final environment = EnvironmentStep(flavors: flavors, current: config.environment).collect();

    await const ConfigSectionWriter().write({
      'environment': {
        'enabled': environment.enabled,
        'configurations': {
          for (final entry in environment.configurations.entries) entry.key: entry.value.toMap(),
        },
      },
    });
  }

  Future<void> _updateFirebase(InitConfig config) async {
    final platforms = ConfigMapper.toPlatformSetup(config);
    final flavors = ConfigMapper.toFlavorSetup(config);

    final firebase = FirebaseStep(platforms: platforms, flavors: flavors, current: config.firebase).collect();

    await const ConfigSectionWriter().write({
      'firebase': {
        'enabled': firebase.enabled,
        'tester_group': firebase.testerGroup,
        'configurations': {
          for (final entry in firebase.configurations.entries) entry.key: entry.value.toMap(),
        },
      },
    });
  }

  Future<void> _updateLocalization(InitConfig config) async {
    final localization = LocalizationStep(current: config.localization).collect();

    await const ConfigSectionWriter().write({
      'localization': {
        'enabled': localization.enabled,
        'arb_dir': localization.arbDir,
        'template': localization.templateArb,
        'output_dir': localization.outputDir,
        'output_file': localization.outputFile,
        'default_locale': localization.defaultLocale,
        'locales': localization.locales,
      },
    });
  }
}
