import 'template_locator.dart';

/// Provides utilities for rendering FKIT templates.
class TemplateRenderer {
  const TemplateRenderer._();

  /// Replaces template placeholders in [value] using the provided [variables].
  ///
  /// Placeholders use the `{{variable}}` format.
  static String renderString(
    String value,
    Map<String, String> variables,
  ) {
    var result = value;

    for (final entry in variables.entries) {
      result = result.replaceAll(
        '{{${entry.key}}}',
        entry.value,
      );
    }

    return result;
  }

  /// Loads and renders a template using the provided [variables].
  ///
  /// The template is resolved relative to [templateRoot] and returned with
  /// matching placeholders replaced by their configured values.
  static Future<String> render({
    required String templateRoot,
    required String template,
    Map<String, String> variables = const {},
  }) async {
    final file = await const TemplateLocator().resolve(
      '$templateRoot/$template',
    );

    final content = await file.readAsString();

    return renderString(
      content,
      variables,
    );
  }
}
