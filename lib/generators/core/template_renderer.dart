import 'generator_context.dart';
import 'template_locator.dart';

class TemplateRenderer {
  const TemplateRenderer._();

  static String renderString(String value, Map<String, String> variables) {
    var result = value;

    for (final entry in variables.entries) {
      result = result.replaceAll('{{${entry.key}}}', entry.value);
    }

    return result;
  }

  static Future<String> render(
      {required GeneratorContext context, required String template, Map<String, String> variables = const {}}) async {
    final file = await const TemplateLocator().resolve('${context.template.name}/$template');

    final content = await file.readAsString();

    return renderString(content, variables);
  }
}
