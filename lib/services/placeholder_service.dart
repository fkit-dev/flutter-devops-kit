/// Provides utilities for replacing placeholders in generated content.
class PlaceholderService {
  /// Replaces placeholders in [input] using the provided [feature] name.
  static String replace({
    required String input,
    required String feature,
  }) {
    final snake = _toSnake(feature);

    final pascal = _toPascal(feature);

    final camel = _toCamel(feature);

    return input
        .replaceAll('{{feature}}', snake)
        .replaceAll('{{feature_snake}}', snake)
        .replaceAll('{{feature_pascal}}', pascal)
        .replaceAll('{{feature_camel}}', camel);
  }

  static String _toSnake(String input) {
    return input.replaceAll('-', '_').toLowerCase();
  }

  static String _toPascal(String input) {
    return input
        .split('_')
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join();
  }

  static String _toCamel(String input) {
    final pascal = _toPascal(input);

    return pascal[0].toLowerCase() + pascal.substring(1);
  }
}
