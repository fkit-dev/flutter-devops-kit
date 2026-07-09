import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../models/localization_setup.dart';
import '../wizard_step.dart';

class LocalizationStep extends WizardStep<LocalizationSetup> {
  @override
  LocalizationSetup collect() {
    LoggerService.blank();

    LoggerService.info('Localization');

    final enabled = PromptService.confirm(
      'Enable localization?',
      defaultValue: false,
    );

    if (!enabled) {
      return const LocalizationSetup(
        enabled: false,
        arbDir: 'lib/l10n',
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

    final outputDir = PromptService.ask(
      'Generated output directory',
      defaultValue: 'lib/gen/l10n',
    );

    final outputFile = PromptService.ask(
      'Output localization file',
      defaultValue: 'app_localizations.dart',
    );

    final defaultLocale = PromptService.ask(
      'Default locale',
      defaultValue: 'en',
    );

    final localeInput = PromptService.ask(
      'Supported locales',
      defaultValue: defaultLocale,
    );

    final locales = localeInput
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    return LocalizationSetup(
      enabled: true,
      arbDir: arbDir,
      outputDir: outputDir,
      outputFile: outputFile,
      defaultLocale: defaultLocale,
      locales: locales,
    );
  }
}
