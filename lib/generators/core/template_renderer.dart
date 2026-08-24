import 'template_locator.dart';

/// Provides utilities for rendering FKIT templates.
class TemplateRenderer {
  const TemplateRenderer._();

  /// Replaces template placeholders in [value] using the provided [variables].
  ///
  /// Supported syntax:
  ///
  /// - `{{variable}}`
  /// - `{{#if variable}} ... {{/if}}`
  static String renderString(
    String value,
    Map<String, dynamic> variables,
  ) {
    var result = value;

    result = _renderConditionals(
      result,
      variables,
    );

    final sorted = variables.entries.toList()
      ..sort((a, b) => b.key.length.compareTo(a.key.length));

    for (final entry in sorted) {
      result = result.replaceAll(
        '{{${entry.key}}}',
        entry.value.toString(),
      );
    }

    return result;
  }

  /// Renders conditional template blocks.
  ///
  /// Example:
  ///
  /// ```text
  /// {{#if enable_dark_theme}}
  /// ...
  /// {{/if}}
  /// ```
  static String _renderConditionals(
    String value,
    Map<String, dynamic> variables,
  ) {
    final pattern = RegExp(
      r'\{\{#if\s+(\w+)\}\}([\s\S]*?)\{\{\/if\}\}',
      multiLine: true,
    );

    return value.replaceAllMapped(pattern, (match) {
      final key = match.group(1)!;
      final body = match.group(2)!;

      final enabled = _isTruthy(variables[key]);

      return enabled ? body : '';
    });
  }

  /// Loads and renders a template using the provided [variables].
  ///
  /// The template is resolved relative to [templateRoot] and returned with
  /// matching placeholders replaced by their configured values.
  static Future<String> render({
    required String templateRoot,
    required String template,
    Map<String, dynamic> variables = const {},
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

  static bool _isTruthy(dynamic value) {
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    return false;
  }
}
