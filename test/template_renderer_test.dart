import 'package:flutter_devops_kit/generators/core/template_renderer.dart';
import 'package:test/test.dart';

void main() {
  group('TemplateRenderer', () {
    group('renderString', () {
      test('replaces single variable', () {
        final result = TemplateRenderer.renderString(
          'class {{feature}} {',
          {'feature': 'auth'},
        );
        expect(result, 'class auth {');
      });

      test('replaces multiple variables', () {
        final result = TemplateRenderer.renderString(
          '{{featurePascal}}Bloc {{feature}}_event.dart {{feature}}_state.dart',
          {
            'feature': 'auth',
            'featurePascal': 'Auth',
          },
        );
        expect(result, 'AuthBloc auth_event.dart auth_state.dart');
      });

      test('handles substring-safe ordering', () {
        final result = TemplateRenderer.renderString(
          '{{featurePascal}} {{feature}}',
          {
            'feature': 'auth',
            'featurePascal': 'Auth',
          },
        );
        expect(result, 'Auth auth');
      });

      test('longer keys replaced before shorter ones', () {
        final result = TemplateRenderer.renderString(
          '{{resource}} {{resourceName}} {{resourcePascal}}',
          {
            'resource': 'login',
            'resourceName': 'LoginRequest',
            'resourcePascal': 'LoginRequest',
          },
        );
        expect(result, 'login LoginRequest LoginRequest');
      });

      test('missing variable stays as-is', () {
        final result = TemplateRenderer.renderString(
          '{{present}} {{missing}}',
          {'present': 'here'},
        );
        expect(result, 'here {{missing}}');
      });

      test('empty variables map returns original string', () {
        final result = TemplateRenderer.renderString(
          'unchanged',
          {},
        );
        expect(result, 'unchanged');
      });

      test('empty value replaces variable with empty string', () {
        final result = TemplateRenderer.renderString(
          'before{{var}}after',
          {'var': ''},
        );
        expect(result, 'beforeafter');
      });

      test('variable appearing multiple times is replaced everywhere', () {
        final result = TemplateRenderer.renderString(
          '{{x}} {{x}} {{x}}',
          {'x': 'val'},
        );
        expect(result, 'val val val');
      });
    });
  });
}
