import '../../models/localization/localization_config.dart';
import '../../services/logger_service.dart';
import '../../services/prompt_service.dart';
import '../wizard_step.dart';

/// Collects localization configuration during the initialization wizard.
class LocalizationStep extends WizardStep<LocalizationConfig> {
  /// The existing localization configuration.
  final LocalizationConfig? current;

  /// Creates a localization configuration step.
  LocalizationStep({
    this.current,
  });

  @override
  LocalizationConfig collect() {
    LoggerService.blank();
    LoggerService.info('Localization');

    final enabled = PromptService.confirm(
      'Enable localization?',
      defaultValue: current?.enabled ?? false,
    );

    if (!enabled) {
      return LocalizationConfig(
        enabled: false,
        arbDir: current?.arbDir ?? 'lib/l10n',
        templateArb: current?.templateArb ?? 'app_en.arb',
        outputDir: current?.outputDir ?? 'lib/gen/l10n',
        outputFile: current?.outputFile ?? 'app_localizations.dart',
        defaultLocale: current?.defaultLocale ?? 'en',
        locales: current?.locales ?? const ['en'],
      );
    }

    final arbDir = PromptService.ask(
      'ARB directory',
      defaultValue: current?.arbDir ?? 'lib/l10n',
    );

    final defaultLocale = PromptService.ask(
      'Default locale',
      defaultValue: current?.defaultLocale ?? 'en',
    );

    final templateArb = PromptService.ask(
      'Template ARB file',
      defaultValue: _resolveTemplateArb(
        defaultLocale,
      ),
    );

    final outputDir = PromptService.ask(
      'Generated output directory',
      defaultValue: current?.outputDir ?? 'lib/gen/l10n',
    );

    final outputFile = PromptService.ask(
      'Output localization file',
      defaultValue: current?.outputFile ?? 'app_localizations.dart',
    );

    final localeInput = PromptService.ask(
      'Supported locales',
      defaultValue: current?.locales.join(',') ?? defaultLocale,
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

  String _resolveTemplateArb(String defaultLocale) {
    final currentTemplate = current?.templateArb;

    if (currentTemplate != null && currentTemplate.isNotEmpty) {
      return currentTemplate;
    }

    return 'app_$defaultLocale.arb';
  }
}
