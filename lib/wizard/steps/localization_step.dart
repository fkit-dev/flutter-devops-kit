import '../../models/localization/localization_config.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../wizard_step.dart';

/// Collects localization configuration during the initialization wizard.
class LocalizationStep extends WizardStep<LocalizationConfig> {
  @override
  LocalizationConfig collect() {
    LoggerService.blank();
    LoggerService.info('Localization');

    final enabled = PromptService.confirm(
      'Enable localization?',
      defaultValue: false,
    );

    if (!enabled) {
      return const LocalizationConfig(
        enabled: false,
        arbDir: 'lib/l10n',
        templateArb: 'app_en.arb',
        outputDir: 'lib/gen/l10n',
        outputFile: 'app_localizations.dart',
        defaultLocale: 'en',
        locales: ['en'],
      );
    }

    final arbDir = PromptService.ask(
      'ARB directory',
      defaultValue: 'lib/l10n',
    );

    final defaultLocale = PromptService.ask(
      'Default locale',
      defaultValue: 'en',
    );

    final templateArb = PromptService.ask(
      'Template ARB file',
      defaultValue: 'app_$defaultLocale.arb',
    );

    final outputDir = PromptService.ask(
      'Generated output directory',
      defaultValue: 'lib/gen/l10n',
    );

    final outputFile = PromptService.ask(
      'Output localization file',
      defaultValue: 'app_localizations.dart',
    );

    final localeInput = PromptService.ask(
      'Supported locales',
      defaultValue: defaultLocale,
    );

    final locales = localeInput.split(',').map((locale) => locale.trim()).where((locale) => locale.isNotEmpty).toSet().toList();

    return LocalizationConfig(
      enabled: true,
      arbDir: arbDir,
      templateArb: templateArb,
      outputDir: outputDir,
      outputFile: outputFile,
      defaultLocale: defaultLocale,
      locales: locales,
    );
  }
}
